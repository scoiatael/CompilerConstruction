#include <sstream>

#include "assert.h"
#include "reader.h"
#include "tokenizer.h"
#include "parsestack.h"

// #define DEBUG

#ifdef DEBUG
#define DEB(X,Y) X
#endif

#ifndef DEBUG
#define DEB(X,Y) Y
#endif

enum AST_type {
  lisp_atom,
  lisp_number,
  lisp_list
};

struct AST_node {
  bool initialized;
  AST_type type;
  double number;
  std::string id;
  std::vector<AST_node> list;
  AST_node* parent;

  std::string str() {
    std::stringstream buf;
    if(!this->initialized) {
DEB(
    buf << "NIL" << "{nothing #" << this << "}";
,
    buf << "NIL";
)
      return buf.str();
    }
    switch(this->type)
      {
      case lisp_atom:
        buf << "ATOM(" << this->id << ")";
        break;
      case lisp_number:
        buf << "NUMBER(" << this->number << ")";
        break;
      case lisp_list:
        if(list.size() == 0) {
          buf << "()";
        } else {
          if(list.front().initialized || list.back().initialized) {
            buf << "CONS(" << this->list.front().str() << ", " << this->list.back().str() << ")";
          } else {
DEB(
            buf << "NIL-CONS(" << this->list.front().str() << ", " << this->list.back().str() << ")";
,
            buf << "CONS(" << this->list.front().str() << ", " << this->list.back().str() << ")";
)
          }
        }
        break;

      }

    return buf.str();
  }

  AST_node() { }

  AST_node(const AST_node& other) {
    this->initialized = other.initialized;
    this->type = other.type;
    this->number = other.number;
    this->id = other.id;
    this->list = other.list;
    this->parent = other.parent;
  }

  AST_node(AST_node* parent) {
    this->initialized = true;
    this->type = lisp_list;
    this->list.clear();
    this->parent = parent;
  }

  AST_node(AST_node* parent, double number) {
    this->initialized = true;
    this->type = lisp_number;
    this->number = number;
    this->parent = parent;
  }

  AST_node(AST_node* parent, std::string id) {
    this->initialized = true;
    this->type = lisp_atom;
    this->id = id;
    this->parent = parent;
  }

  AST_node* add_children() {
    this->list.push_back(AST_node(this));
    this->list.push_back(AST_node(this));
    AST_node
      *head = &this->list.front(),
      *tail = &this->list.back();
    head -> initialized = false;
    tail -> initialized = false;
    head->parent = tail;
    return head;
  }
};

int main()
{

   tokenizer tt;

   parsestack p( tkn_Start, 0 );
      // Start in state 0 for token tkn_Start.

   AST_node result;
   result.parent = NULL;
   AST_node* current_result_node = &result;

   while( ! p. accepts( tt ))
   {
DEB(
      std::cout << p << "\n";
,)
      if( tt. lookahead. size( ) == 0 )
         tt. scan( );

      const token& lookahead = tt.lookahead.front();
DEB(
      std::cout << "result = " << result.str() << "\n";
      std::cout << "current_result_node = " << (current_result_node == NULL ? "NULL" : current_result_node->str()) << "\n";
      std::cout << "lookahead symbol = " << lookahead << "\n";
      std::cout.flush();
,)

      if(p.accepts(tt)) break;

      if( p. size( ) == 0 )
      {
         std::cout << "unexpected end of file\n";
         return 0;
      }

      const position& top = p. top( );
DEB(
      std::cout << "top = " << top << "\n\n";
,)

      // You can use nested switches, nested ifs, or use tables,
      // whatever you think gives the nices solution.

      switch( top. type )
      {
      case tkn_Start:
        switch(lookahead.type)
          {
          case tkn_RPAR:
            assert(top.state == 1);
            p.close();
            tt. lookahead. pop_front( );
            break;
          case tkn_LPAR:
            assert(top.state == 0);
            tt. lookahead. pop_front( );
            p.descend(1, tkn_LPAR, 0);
            break;
          default:
            assert(top.state == 0);
            switch(lookahead.type)
              {
              case tkn_NUMBER:
                *current_result_node = AST_node(current_result_node->parent, lookahead.value.front());
                break;
              case tkn_IDENTIFIER:
                *current_result_node = AST_node(current_result_node->parent, lookahead.id.front());
                break;
              default:
                assert(false);
              }
            current_result_node = current_result_node->parent;
            tt. lookahead. pop_front( );
            p.close();
          }
        break;
      case tkn_LPAR:
        switch(lookahead.type)
          {
          case tkn_RPAR:
            if(top.state == 1) {
                current_result_node = current_result_node->parent->parent;
            }
            p.close();
            break;
          default:
            *current_result_node = AST_node(current_result_node->parent);
            current_result_node = current_result_node->add_children();
            p.descend(1, tkn_Start, 0);
          }
        break;
      default:
        assert(false);
      }
   }

   // Actually if the size of lookahead gets 0, something went wrong.

   ASSERT( tt. lookahead. size( ));
DEB(
    std::cout << tt. lookahead. front( ) << "\n";
    // This is an EOF token.
,)
   std::cout << result.str() << "\n";;
   return 0;

}

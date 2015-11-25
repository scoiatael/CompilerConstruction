#include <sstream>

#include "assert.h"
#include "reader.h"
#include "tokenizer.h"
#include "parsestack.h"

int main( int argc, char* argv [] )
{

   tokenizer tt;

   parsestack p( tkn_Start, 0 );
      // Start in state 0 for token tkn_Start.

   std::stringstream result;

   while( ! p. accepts( tt ))
   {
      std::cout << p << "\n";
      if( tt. lookahead. size( ) == 0 )
         tt. scan( );

      const token& lookahead = tt.lookahead.front();
      std::cout << "result = " << result.str() << "\n";
      std::cout << "lookahead symbol = " << lookahead << "\n";

      if(p.accepts(tt)) break;

      if( p. size( ) == 0 )
      {
         std::cout << "unexpected end of file\n";
         return 0;
      }

      const position& top = p. top( );
      std::cout << "top = " << top << "\n\n";

      // You can use nested switches, nested ifs, or use tables,
      // whatever you think gives the nices solution.

      switch( top. type )
      {
      case tkn_Start:
        switch(lookahead.type)
          {
          case tkn_RPAR:
            if (top.state == 1) {
              p.close();
            } else {
              assert(false);
            }
            break;
          case tkn_LPAR:
            if (top.state == 0) {
              p.descend(1, tkn_LPAR, 1);
            } else {
              assert(false);
            }
            break;
          case tkn_IDENTIFIER:
            if(top.state == 0 && lookahead.id.front() == "nil") {
              result << "()";
              p.close();
            } else {
              std::cerr << "Bad identifier in " << top << " : " << lookahead.id.front() << "\n";
            }
            break;
          default:
            std::cerr << "Unhandled token in " << top << " : " << lookahead << "\n\n";
          }
        tt. lookahead. pop_front( );
        break;
      case tkn_LPAR:
        if(top.state == 1){
          result << " cons(";
          p.read(0);
        }
        switch(lookahead.type)
          {
          case tkn_RPAR:
            result << ")";
            p.close();
            break;
          case tkn_IDENTIFIER:
            if(lookahead.id.front() == "nil") {
              p.descend(0, tkn_Start, 0);
            } else {
              result << "I[" << lookahead << "]";
              tt. lookahead. pop_front( );
              p.descend(0, tkn_LPAR, 1);
            }
            break;
          case tkn_NUMBER:
            result << "N[" << lookahead << "]";
            tt. lookahead. pop_front( );
            p.descend(0, tkn_LPAR, 1);
            break;
          case tkn_LPAR:
            p.descend(1, tkn_Start, 0);
            break;
          default:
            std::cerr << "Unhandled token in " << top << " : " << lookahead << "\n\n";
            tt. lookahead. pop_front( );
          }
        break;
      default:
        std::cerr << "Unhandled state: " << top << "\n\n";
        tt. lookahead. pop_front( );
      }
   }

   // Actually if the size of lookahead gets 0, something went wrong.

   ASSERT( tt. lookahead. size( ));
   std::cout << tt. lookahead. front( ) << "\n";
      // This is an EOF token.
   std::cout << result.str() << "\n";;
   return 0;

}

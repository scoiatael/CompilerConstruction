#include "tree.h"


%token EOF SCANERROR
%token SEMICOLON BECOMES COMMA 
%token IDENTIFIER NUMBER 
%token PLUS TIMES MINUS DIVIDES
%token FACTORIAL
%token LPAR RPAR

// Non-terminal symbols:

%token E F G H LISTARGS
%token Session Command
%token Start

%startsymbol Session EOF

%attribute value         double
%attribute id            std::string
%attribute reason        std::string
%attribute trees         tree

%constraint IDENTIFIER  id 1 2
   // You may write the others.
%constraint E trees 1 2
%constraint F trees 1 2
%constraint G trees 1 2
%constraint H trees 1 2
%constraint LISTARGS trees 0
%constraint SCANERROR reason 1 2
%constraint NUMBER value 1 2

%global memory varstore
   // Contains the stored variables.

#include "varstore.h"

#include "assert.h"
#include <math.h>


% Start : Session EOF
   std::cout << "bye bye\n";
%   ;

% Session : Session Command 
%         |
%         ;


% Command : E SEMICOLON

    std::cout << " Tree:\n  " << E1 -> trees. front( ) << "\n";
    std::cout << "\tResult:  " << E1 -> trees. front( ).eval(memory) << "\n";

%         | IDENTIFIER BECOMES E SEMICOLON

    tree result("=", std::vector<tree>{ IDENTIFIER1->trees.front(), E3->trees.front() });
    std::cout << " Tree:\n  " << result << "\n";
    std::cout << "\tResult:  " << result.eval(memory) << "\n";

%         | _recover SEMICOLON

   std::cout << "recovered from error\n\n";

%         ;

% E   : E PLUS F 

   // If both E1 and F3 are defined, then compute result:

   E1 -> trees.front() = tree("+", std::vector<tree>{E1 -> trees. front( ), F3 -> trees. front( )});
   return E1;

%     | E MINUS F

   // If both E1 and F3 are defined, then compute result:

   E1 -> trees.front() = tree("-", std::vector<tree>{E1 -> trees. front( ), F3 -> trees. front( )});
   return E1;

%     | F

   // Change F into E, don't touch attribute.

   F1 -> type = tkn_E;
   return F1;

%     ;

% F   : F TIMES G

    // If both E1 and F3 are defined, then compute result:

    F1 -> trees.front() = tree("*", std::vector<tree>{F1 -> trees. front( ), G3 -> trees. front( )});
    return F1;

%     | F DIVIDES G

   F1 -> trees.front() = tree("/", std::vector<tree>{F1 -> trees. front( ), G3 -> trees. front( )});
   return F1;

%     | G

   G1 -> type = tkn_F;
   return G1;

%     ;


%  G : MINUS G

   G2 -> trees.front() = tree("-", std::vector<tree>{G2 -> trees.front()} );
   return G2;

%    | PLUS G

   G2 -> trees.front() = tree("+", std::vector<tree>{G2 -> trees.front()} );
   return G2;

%    | H

   H1 -> type = tkn_G;
   return H1;

%    ;


% H   : H FACTORIAL

   H1 -> trees.front() = tree("!", std::vector<tree>{H1 -> trees.front()} );
   return H1;

%     | LPAR E RPAR

   E2 -> type = tkn_H;
   return E2;

%     | IDENTIFIER

   token h = tkn_H;
   h.trees.push_back(tree(IDENTIFIER1 -> id. front( )));
   return h;

%     | NUMBER

   token h = tkn_H;
   h.trees.push_back(tree(NUMBER1 -> value. front( )));
   return h;

%     | IDENTIFIER LPAR LISTARGS RPAR 

   token h = tkn_H;
   h.trees.push_back( tree(IDENTIFIER1 -> id.front(), std::vector<tree>{std::begin(LISTARGS3 -> trees), std::end(LISTARGS3 -> trees)}));
   return h;

%     ;


% LISTARGS : E

   E1 -> type = tkn_LISTARGS;
   return E1;

%          | LISTARGS COMMA E

    LISTARGS1 -> trees.push_back(E3 -> trees.front());
    return LISTARGS1;

%          ;





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

%constraint IDENTIFIER  id 1 2
   // You may write the others.

%global memory varstore
   // Contains the stored variables.

#include "varstore.h"
#include "tree.h"

#include "assert.h"
#include <math.h>


% Start : Session EOF
   std::cout << "bye bye\n";
%   ;

% Session : Session Command 
%         |
%         ;


% Command : E SEMICOLON

   if( E1 -> value. size( ))
      std::cout << " Result:  " << E1 -> value. front( ) << "\n";
   else
      std::cout << " Result is undefined\n";

%         | IDENTIFIER BECOMES E SEMICOLON

   if( E3 -> value. size( ))
   {
      std::cout << " Assigning: " << IDENTIFIER1 -> id. front( ) << " := ";
      std::cout << E3 -> value. front( ) << "\n";
      memory. assign( IDENTIFIER1 -> id. front( ), E3 -> value. front( ));
   }
   else
      std::cout << " Result is undefined\n";

%         | _recover SEMICOLON

   std::cout << "recovered from error\n\n";

%         ;

% E   : E PLUS F 

   // If both E1 and F3 are defined, then compute result:

   if( E1 -> value. size( ) && F3 -> value. size( ))
      E1 -> value. front( ) += F3 -> value. front( );
   else
      E1 -> value. clear( );
   return E1;

%     | E MINUS F 

%     | F 

   // Change F into E, don't touch attribute.

   F1 -> type = tkn_E;
   return F1;

%     ;

% F   : F TIMES G 

%     | F DIVIDES G

   if( F1 -> value. size( ) && G3 -> value. size( ))
   {
      if( G3 -> value. front( ) != 0.0 )
         F1 -> value. front( ) /= G3 -> value. front( );
      else
      {
         std::cout << "division by zero!\n";
         F1 -> value. clear( );
      }
   }
   else
      F1 -> value. clear( );
 
   return F1;
 
%     | G 

%     ;


%  G : MINUS G 

%    | PLUS G 

%    | H 

%    ;


% H   : H FACTORIAL

   if( ! H1 -> value. size( ))
      return H1;

   if( H1 -> value. front( ) >= 0 &&
       floor( H1 -> value. front( )) == H1 -> value. front( ))
   {
      unsigned int f = static_cast< unsigned int >
         ( floor( H1 -> value. front( ) + 0.1 ));

      double res = 1.0;
      while( f != 0 )
      {
         res *= f;
         -- f;
      }
   
      H1 -> value. front( ) = res;
   }
   else
   {
      std::cout << "cannot compute " << H1 -> value. front( ) << " !\n\n";
      H1 -> value. clear( );
   }

   return H1;
 
%     | LPAR E RPAR 
 
   E2 -> type = tkn_H;
   return E2;

%     | IDENTIFIER 

   token h = tkn_H;
   if( memory. contains( IDENTIFIER1 -> id. front( )))
   {
      h. value. push_back( memory. lookup( IDENTIFIER1 -> id. front( )));
      return h; 
   }
   else
   {
      std::cout << "variable " << IDENTIFIER1 -> id. front( );
      std::cout << " has no value!\n";
      return tkn_H;
   }

%     | NUMBER 

   NUMBER1 -> type = tkn_H;
   return NUMBER1;

%     | IDENTIFIER LPAR LISTARGS RPAR 

   token h = tkn_H;
   if( IDENTIFIER1 -> id. front( ) == "sin" &&
       LISTARGS3 -> value. size( ) == 1 ) 
   {
      h. value. push_back( sin( LISTARGS3 -> value. front( )));
      return h;
   }

   if( IDENTIFIER1 -> id. front( ) == "pow" &&
       LISTARGS3 -> value. size( ) == 2 )
   {
      h. value. push_back( pow( LISTARGS3 -> value. front( ),
                                LISTARGS3 -> value. back( )));
      return h;
   }

   std::cout << "unrecognized function!\n";
   return h;
      // With empty attribute.

%     ;


% LISTARGS : E 
%          | LISTARGS COMMA E
%          ;




// This code was produced by Maphoon 2008.
// Code of struct token:


#include "token.h"


bool token::iswellformed( ) const
{
   switch( type )
   {
   case tkn__recover:
   case tkn__defaultred:
   case tkn_IDENTIFIER:
   case tkn_PLUS_SIGN:
   case tkn_STAR_SIGN:
   case tkn_LEFT_PARANTHESES:
   case tkn_RIGHT_PARANTHESES:
   case tkn_EOF:
   case tkn_S:
   case tkn_T:
   case tkn_U:
      return true;
   }
   return false; // Because of unknown type.
}


// If you see an insane error message originating from
// this point, then the most probable reason is that
// one of the attribute types has no print function defined.

std::ostream& operator << ( std::ostream& stream, const token& t )
{
   switch( t. type )
   {
   case tkn__recover:
      stream << "_recover( "; break;
   case tkn__defaultred:
      stream << "_defaultred( "; break;
   case tkn_IDENTIFIER:
      stream << "IDENTIFIER( "; break;
   case tkn_PLUS_SIGN:
      stream << "PLUS_SIGN( "; break;
   case tkn_STAR_SIGN:
      stream << "STAR_SIGN( "; break;
   case tkn_LEFT_PARANTHESES:
      stream << "LEFT_PARANTHESES( "; break;
   case tkn_RIGHT_PARANTHESES:
      stream << "RIGHT_PARANTHESES( "; break;
   case tkn_EOF:
      stream << "EOF( "; break;
   case tkn_S:
      stream << "S( "; break;
   case tkn_T:
      stream << "T( "; break;
   case tkn_U:
      stream << "U( "; break;
   default:
      stream << "UNKNOWNTOKEN( ";
   }

   unsigned int arg = 0;
   unsigned int arginlist;

   stream << " )";
   return stream;
}



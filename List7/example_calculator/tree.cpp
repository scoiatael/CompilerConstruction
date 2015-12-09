
#include "tree.h"

namespace
{
   void printindent( unsigned int indent, std::ostream& out )
   {
      for( unsigned int i = 0; i < indent; ++ i )
         out << "   ";
   }

   void printtree( unsigned int indent, std::ostream& out, const tree& t )
   {
      printindent( indent, out );
      t. printnode( out ); 
      out << "\n";

      for( size_t i = 0; i < t. nrsubtrees( ); ++ i )
      {
         printtree( indent + 1, out, t[i] );
      }
   }

}

double tree::eval(varstore& vars) const
{
  if( this->hasstring() ) {
    const tree& self = *(this);
    const std::string& thisstring = this->getstring();
    if( this->nrsubtrees() == 0) {
      if( vars.contains( thisstring ) ) {
        return vars.lookup( thisstring );
      } else {
        throw std::runtime_error("No variable found");
      }
    } else {
      if(thisstring == "sin") {
        return sin( self[0].eval(vars));
      }

      double rhs = self[1].eval(vars);
      if(thisstring == "pow") {
        return pow( self[0].eval(vars), rhs);
      }

      switch(thisstring[0]) {
      case '+':
        return self[0].eval(vars) + rhs;
      case '-':
        return self[0].eval(vars) - rhs;
      case '/':
        if(rhs == 0) {
          throw std::runtime_error("Division by 0");
        }
        return self[0].eval(vars) / rhs;
      case '*':
        return  self[0].eval(vars) * rhs;
      case '=':
        vars. assign( self[0].getstring(), rhs);
        return rhs;
      default:
        throw std::runtime_error("Unknown function");
      }
    }
  } else {
    if( this->hasdouble() ) {
      return this->getdouble();
    } else {
      throw std::runtime_error("Empty node");
    }
  }
  return -1;
}


std::ostream& operator << ( std::ostream& out, const tree& t )
{
   printtree( 0, out, t ); 
   return out;
}


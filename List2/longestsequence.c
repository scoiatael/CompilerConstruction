#include <stdlib.h>
#include <stdio.h>

size_t longestsequence( size_t upperbound )
{
  size_t longesti = 0;
  size_t longeststop = 0;
  for( size_t i = 1; i < upperbound; ++ i )
    {
      size_t length = 0;
      size_t val = i;
      while( val != 1 )
        {
          if( val & 1 )
            val = val * 3 + 1;
          else
            val = val / 2;
          ++ length;
        }
      if( length > longeststop )
        {
          longesti = i;
          longeststop = length;
        }
    }
  return longesti;
}

int main() {
  const size_t arg = 10;
  printf("longestsequence(%ld)=%ld\n", arg, longestsequence(arg));
}

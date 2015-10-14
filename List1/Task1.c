// This one uses phi function
// because the other one uses memory allocation

// nsw flag means operation is guaranteed not to overflow in signed case
// nuw means the same for unsigned
char tolower1( char c )
{
  return c >= 'A' && c <= 'Z' ? c - 'A' + 'a' : c;
}
char tolower2( char c )
{
  if( c >= 'A' && c <= 'Z' )
    c += 'a' - 'A'; // replace capitalism by lowercasism.
  return c;
}

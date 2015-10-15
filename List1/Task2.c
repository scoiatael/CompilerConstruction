char tolower(char s) {
  return s;
}

void tolower_str1( char* s )
{
  while( *s != '\0' )
    {
      *s = tolower( *s );
      s ++ ;
    }
}

void tolower_str2( char* s )
{
  while( *s != '\0' )
    {
      *s = tolower( *s );
      ++s ;
    }
}

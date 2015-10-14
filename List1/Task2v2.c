char tolower(char s) {
  return s;
}

void tolower_str( char* s )
{
  while( *s != '\0' )
    {
      *s = tolower( *s );
      ++s ;
    }
}

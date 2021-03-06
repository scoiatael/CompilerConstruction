

// Code generated by Maphoon 2008. 
// Written by Hans de Nivelle, June 2008.
// See the licence that was included with the code. 


namespace
{
   struct refused
   {
   };

   std::ostream& operator << ( std::ostream& stream, refused ref )
   {
      stream << "REFUSED";
      return stream;
   }
}



namespace
{

// Here come the tables:

$X$

}


namespace
{


   // There are two reduce functions.
   // 
   // The first returns a token from the parse stack.
   // The other tokens are removed, and it is checked that the
   // token has the right type.
   // 
   // The second returns a new token. All tokens from the parse stack
   // are removed, and the new token is pushed.

   void reduce( std::list< $T$ > & parsestack,
                std::list< $T$ > :: iterator position,
                $T$type expectedtype,
                std::list< $T$ > :: const_iterator result )
   {
      ASSERT( result -> type == expectedtype );
         // Must be type of lhs. 
      ASSERT( result -> iswellformed( ));

      bool seen = false;
      while( position != parsestack. end( ))
      {
         if( position == result )
         {
            ASSERT( !seen );
            seen = true;
            ++ position;
         }
         else
         {
            std::list< $T$ > :: iterator p1 = position;
            ++ position; 
            parsestack. erase( p1 );
         }
      }
      ASSERT( seen );
   }


   void reduce( std::list< $T$ > & parsestack,
                std::list< $T$ > :: iterator position,
                $T$type expectedtype,
                const $T$& result )
   {
      ASSERT( result. type == expectedtype ); 
      ASSERT( result. iswellformed( )); 

      while( position != parsestack. end( ))
      {
         ASSERT( & (*position) != & result );
            // If this happenes, the user typed 'return *T'
            // for an attribute variable. 
            // He should have typed 'return T' instead. 
  
         std::list< $T$ > :: iterator p1 = position;
         ++ position;
         parsestack. erase( p1 ); 
      }

      parsestack. insert( position, result ); 
   }


   // This is not terribly efficient, but we expect the size of the
   // rules to be moderate.

   std::list< $T$ > :: iterator 
   operator - ( std::list< $T$ > :: iterator p,
                unsigned int diff )
   {
      while( diff > 0 )
      {
         -- diff; 
         -- p;
      }
      return p; 
   }


// Here come the actions:

$A$


   
   // The return values are specified as follows: 
   // 
   //                 0 : error.
   //        10000 + X  : push to state X.
   //        -10000 - X : Reduce rule X.
   // 
   // The returned list contains a sequence of reductions, terminated 
   // by an error or a push. 
   //
   // We try to base our decision on lookahead. If more lookahead
   // is required, we extend lookahead by doing: 
   //    lookahead. push_back( input. scan( ));
   

   std::list< int > decideaction( unsigned int ss, $R$& input )
   {
      std::list< int > result;

      unsigned int k = starts [ss];
      unsigned int defred = 0;
 
      while( true )
      {
         while( k == starts [ ss + 1 ] )
         {
            // This means that we reached the end.
            // If defaults [ss] != ss, we can continue looking in another
            // state.

            if( defaults [ss] == ss )
            {
               if( defred == 0 )
                  result. push_back(0);
               else
               {
                  result. push_back( defred ); 
                  result. push_back(0);
               }
               return result; 
            }

            ss = defaults [ ss ];
            k = starts [ ss ]; 
         }
          
         if( parsetable [k] == $E$_defaultred )
         {
            ASSERT( parsetable [ k+1 ] < 0 && parsetable [ k+2 ] == 0 );
            ASSERT( defred == 0 );
            defred = parsetable [ k + 1 ];
            k += 3; 
         }
         else
         {
            if( input. lookahead. size( ) == 0 )
            {
               input. scan( );
               ASSERT( input. lookahead. size( ));
               ASSERT( input. lookahead. back( ). iswellformed( ));
            }

            if( input. lookahead. size( ) &&
                input. lookahead. front( ). type == parsetable [k] )
            {
               ++ k; 
               while( parsetable [k] < 0 )
                  result. push_back( parsetable [ k ++ ] );
               result. push_back( parsetable [k] );
               return result;
            }
            
            ++ k;
            while( parsetable [k] < 0 )
               ++ k;
            ++ k; 
         }
      }
   }


   bool stateisempty( unsigned int ss )
   {
      return starts [ss] == starts [ss+1];
   }


   bool isstartlookahead( unsigned int entry, $R$& input )
   { 
      ASSERT( input. lookahead. size( ));

      entry += 2;  
      while( entrypoints [ entry ] >= 0 )
      {
         if( entrypoints [ entry ] == input. lookahead. front( ). type )
            return true;
         ++ entry;
      }
      return false;
   }

}
 

// The tokenizer must have the following features:
// It must have a field std::list< token > lookahead; 
// It must have a method void scan( ), which reads a token from somewhere
// and appends it to lookahead. scan( ) must always return a token,
// also when it reaches end of file, or when it is unable to read 
// input for some kind of reason. 
// It must have a method syntaxerror( ), which reports a syntax error
// to the user. 
// 
// The parser is called with the start symbol of the partial grammar
// that has to be parsed. 
// It uses the lookahead list of the tokenizer for returning its value.
// In case of a successful parse, lookahead starts with the start
// symbol. A second symbol need not be present. If there is a second
// symbol, then it is the lookahead symbol of the original start symbol. 
// The parser will read the lookahead only when it is necessary for
// deciding.
// 
// When an error occurred, and the parser reached a lookahead symbol
// while attempting to recover, the lookahead list equals this 
// lookahead symbol. 
// If the parser gave up, because more than
// recoverlength symbols were read, it returns a list of length 1 
// containing a recover symbol. 

// Setting recoverlength = 0 ensures that the parser will not try to
// recover. 


void $P$( $R$& input$G$, $T$type start, unsigned int recoverlength )
{

   unsigned int errorcount = 0;
      // If errorcount > 0, then errors are not reported. 
      // Instead we assume that the previous recovery was not 
      // successful. 

   unsigned int entry = 0;
   while( entrypoints [ entry ] != -1 && entrypoints [ entry ] != start )
   {
      while( entrypoints [ entry ] != -1 )
         ++ entry;
      ++ entry;
   }

   if( entrypoints [ entry ] != start )
   {
      std::cout<< "could not find startsymbol " << start << "\n";
      ASSERT( false ); 
      exit(0);
   }

   std::list< unsigned int > states; 
   states. push_back( entrypoints [ entry + 1 ] );

   std::list< $T$ > parsestack; 
 
   while( true ) 
   {
      ASSERT( states. size( ) == parsestack. size( ) + 1 );

#ifdef MAPH_DEBUG
      std::cout << "stack of states: "; 
      for( std::list< unsigned int > :: const_iterator
              p = states. begin( );
              p != states. end( );
              ++ p )
      {
         if( p != states. begin( ))
            std::cout << ", "; 
         std::cout << *p;
      }
      std::cout << "\n";

      std::cout << "stack of symbols: "; 
      for( std::list< $T$ > :: const_iterator
              p = parsestack. begin( );
              p != parsestack. end( );
              ++ p )
      {
         if( p != parsestack. begin( ))
            std::cout << ", ";
         std::cout << *p;
      }
      std::cout << "\n";

      if( input. lookahead. size( ))
         std::cout << "lookahead: " << input. lookahead. front( ) << "\n";
#endif
      // We will check if we are in an accepting state. 
      // The parse stack must have size 1, and contain the 
      // start symbol of the grammar.

      if( parsestack. size( ) == 1 && 
          parsestack. front( ). type == entrypoints [ entry ] )
      {
         // This is a good start.
      
         // If we are in an empty state, we simply accept, and that's
         // the end of the story.

         if( stateisempty( states. back( )))
         {
            input. lookahead. splice( input. lookahead. begin( ),
                                      parsestack, parsestack. begin( ));
            
            return;  
         }

         // Otherwise, we check whether lookahead is one of the 
         // lookahead symbols of the start symbol. 
                   
         if( input. lookahead. size( ) == 0 )
         {
            input. scan( );
            ASSERT( input. lookahead. size( ));
            ASSERT( input. lookahead. back( ). iswellformed( ));
         }

         if( isstartlookahead( entry, input )) 
         {
            // This means that we accept. We move the start symbol
            // to the lookahead and quit.

            input. lookahead. splice( input. lookahead. begin( ),
                                     parsestack, parsestack. begin( ));
            return; 
         }
 
         // Otherwise we simply continue, and let things go their way.
         // This does not necessarily imply that there will be an error.
         // It is also possible that the parser will continue.
      }
       
      std::list< int > actions = decideaction( states. back( ), input );

      // If we have reductions, we try to perform them:
      // If we manage to make a reduction, we clear actions,
      // so that we will come out of this loop:

      while( actions. size( ) > 1 ) 
      {
         ASSERT( actions. front( ) < 0 );
         unsigned int rule = - actions. front( ) - 10000;

#ifdef MAPH_DEBUG
         std::cout << "attempting to reduce rule " << rule << "\n";
#endif

         try
         {
            switch( rule ) 
            {
$C$
            default:
	       std::cout << "unknown rule!\n";
	       exit(0); 
            }

#ifdef MAPH_DEBUG
            std::cout << "reduced rule " << rule << "\n";
#endif

            ASSERT( parsestack. size( )); 

            ASSERT( states. size( ) >= parsestack. size( ));

            while( states. size( ) > parsestack. size( ))
               states. pop_back( );

            // We now need to shift the lhs of the rule.
            // We do not like to copy tokens, because their attributes
            // can be big without borders. Copying can be avoided 
            // using list specific operations. 

            std::list< $T$ > :: iterator p = parsestack. end( ) - 1;
            input. lookahead. splice( input. lookahead. begin( ), 
                                      parsestack, p );
               // Now the back of the parsestack is in front of lookahead.
               // It is possible that lookahead has a length of two now.

            actions = decideaction( states. back( ), input ); 

            // The action list should consist of a single push:

            ASSERT( actions. size( ) == 1 && actions. front( ) > 0 );

#ifdef MAPH_DEBUG
            std::cout << "goto " << actions. front( ) - 10000 << "\n"; 
#endif
            // We do not carry out the goto. 

            ++ errorcount;
         }
         catch( refused ref )
         {
#ifdef MAPH_DEBUG
            std::cout << "rule " << rule << " refused\n";
#endif
            actions. pop_front( );
               // But we are not sad about the refusal. We simply try the
               // next. 
         }
      }   
 
      if( actions. size( ) == 1 && actions. front( ) > 0 ) 
      {
         ASSERT( input. lookahead. size( ) == 1 || 
                 input. lookahead. size( ) == 2 );
         actions. front( ) -= 10000;
#ifdef MAPH_DEBUG
         std::cout << "shifting " << input. lookahead. front( ) << "\n"; 
#endif
 
         if( errorcount > 0 ) 
	    -- errorcount; 

         parsestack. splice( parsestack. end( ), 
                             input. lookahead, input. lookahead. begin( ));
            // This puts the symbol on the parsestack without moving it. 

         states. push_back( actions. front( ));

      }
      else
      {
         // If there is something left in actions, it is an error.

         ASSERT( actions. size( ) == 1 && actions. front( ) == 0 );
         ASSERT( input. lookahead. size( ));

#ifdef MAPH_DEBUG
        std::cout << "error!\n"; 
#endif

         // It is the responsability of the tokenizer to process the error:

         input. syntaxerror( );
 
         // Recovery will be the level at which we can recover.
         // As long as we did not recover, it will be -1.
 
         int recovery = -1; 
         unsigned int ignoredtokens = 0;

         while( recovery < 0 && ! isstartlookahead( entry, input ) && 
                ignoredtokens < recoverlength )
         {
            // Our approach is simple and inefficient, we look for
            // states that can push a recovery symbol, and after that
            // would be able to push the current lookahead symbol.

            std::list< unsigned int > :: const_iterator p = states. begin( );

            for( unsigned int k = 0; k < states. size( ); ++ k )
            {
               input. lookahead. push_front( $T$::token( $E$_recover ));
               actions = decideaction( *p, input );
               input. lookahead. pop_front( );

               if( actions. size( ) == 1 && actions. front( ) > 0 )
               {
                  // Recover transition is possible. 

                  unsigned int trans = actions. front( ) - 10000; 
                  actions = decideaction( trans, input );
               
                  if( actions. size( ) == 1 && actions. front( ) > 0 )
                     recovery = k;
                        // We remember that recovery was possible.
                        // If more than recovery is possible, we will
                        // remember the highest in recovery. 
               }
            
               ++ p;
            }
       
            if( recovery < 0 )
            {
               input. lookahead. clear( );
               ++ ignoredtokens;
               input. scan( );
               ASSERT( input. lookahead. size( )); 
               ASSERT( input. lookahead. back( ). iswellformed( ));
            }
         }

#ifdef MAPH_DEBUG 
         std::cout << "recovery = " << recovery << "\n";
         if( input. lookahead. size( ))
         {
            std::cout << "lookahead = ";
            std::cout << input. lookahead. front( ) << "\n";
         }
#endif

         if( ignoredtokens >= recoverlength ) 
         {
            // That was it. Game over. We lost.

            input. lookahead. clear( );
            input. lookahead. push_front( $E$_recover );
            return;
         }

         if( isstartlookahead( entry, input ))
         {
            // We reached a lookahead symbol of the grammar. 
            // We admit our defeat. 

            return;
         } 

         while( states. size( ) > recovery + 1 )
         {
            states. pop_back( );
            parsestack. pop_back( ); 
         }

         input. lookahead. push_front( $T$::token( $E$_recover ));
         actions = decideaction( states. back( ), input );
         input. lookahead. pop_front( );

         ASSERT( actions. size( ) == 1 && actions. front( ) > 0 );
         actions. front( ) -= 10000;
       
         states. push_back( actions. front( ));
         parsestack. push_back( $T$::token( $E$_recover ));

         actions = decideaction( states. back( ), input );
     
         ASSERT( actions. size( ) == 1 && actions. front( ) > 0 );
         actions. front( ) -= 10000;

#ifdef MAPH_DEBUG
         std::cout << "recovering into state " << actions. front( );
         std::cout << " using token " << input. lookahead. front( ) << "\n";
#endif

         states. push_back( actions. front( ));
         parsestack. splice( parsestack. end( ),
                             input. lookahead, input. lookahead. begin( ));

         errorcount = 3;
      }
   }
}



%option noyywrap

%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT    [0-9]
FLOAT    {DIGIT}+("."{DIGIT}+)?([eE]{DIGIT}+("."{DIGIT}+)?)?
ID       [a-z][a-z0-9]*

%%

{DIGIT}+ {
    printf( "(INTEGER: %d) ", atoi( yytext ) );
}

{FLOAT} {
    printf( "(FLOAT: %g) ", atof( yytext ) );
}

if|then|else|fun|type {
    printf( "(KEYWORD: %s) ", yytext );
}

{ID} printf( "(IDENTIFIER: %s) ", yytext );

"+"|"-"|"*"|"/"|":="|"="|"<-"|"->"|"=>" printf( "(OPERATOR: %s) ", yytext );

"/*"((\*+[^/])|[^/*])*"*/" /* eat up one-line comments */

\n+ printf("\n");

[ \t]+ /* eat up whitespace */

"{" printf("(CURLY START) ", yytext);

"(" printf("(PARANTHESES START) ", yytext);

"}" printf("(CURLY END) ", yytext);

")" printf("(PARANTHESES END) ", yytext);

. printf( "Unrecognized character: %s\n", yytext );

%%

int main( int argc, char **argv )
{
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;

    yylex();
}

%token IDENTIFIER
%token PLUS_SIGN STAR_SIGN LEFT_PARANTHESES RIGHT_PARANTHESES
%startsymbol S EOF


% S : S PLUS_SIGN T
%   | T
%   ;


% T : T STAR_SIGN U
%   | U
%   ;

% U : IDENTIFIER
%   | LEFT_PARANTHESES S RIGHT_PARANTHESES
%   ;

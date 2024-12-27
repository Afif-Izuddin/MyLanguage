grammar MyLang;


program      : statement+ ;
statement    : variableDeclaration 
              | printStatement
              | whileLimitStatement
              | whileStatement
              | ifElseStatement
              | forStepStatement
              | forLoopStatement
              | PASS;
variableDeclaration : LET ID '=' expression;
printStatement      : PRINT expression;
whileLimitStatement : WHILE '(' condition LIMIT INT')' '{' statement+ '}';
whileStatement : WHILE '(' condition ')' '{' (statement)* '}' ;
ifElseStatement 
    : IF '(' condition ')' '{' (statement)* '}'
      ( ELIF '(' condition ')' '{' (statement)* '}' )*
      ( ELSE '{' (statement)* '}' )? ;
switchStatement 
    : SWITCH '(' expression ')' '{' 
        ( CASE LITERAL (statement)+ )* 
        ( DEFAULT (statement)+ )? 
      '}' END_SWITCH;
forStepStatement
    : FOR '(' start=INT 'to' goal=INT 'step' step=INT ')' '{' (statement)* '}'; ///Continue Later
forLoopStatement
    : FOR '(' INT ')' '{' (statement)* '}';



comment : '//' STRING* ;
multilineComment : '///' STRING* '///';
iterable            : array
                    | object
                    | ID ;
array               : '[' expression (',' expression)* ']' ;
object : '{' (pair (',' pair)*)? '}' ;
pair  : STRING ':' expression ;
condition           : expression COMPARISON_OP expression
                    | BOOLEAN ;
expression          : INT
                    | STRING
                    | ID
                    | BOOLEAN
                    | array
                    | object
                    | '(' expression OPERATOR expression ')'
                    | expression '?' expression ':' expression ;

LIMIT   : 'limit';
WHILE   : 'while';
FOR     : 'for';
LET     : 'let' ;
ELIF    : 'else if';
PRINT   : 'print' ;
RETURN  : 'return' ;
IF      : 'if' ;
ELSE    : 'else' ;
SWITCH  : 'switch' ;
CASE    : 'case' ;
DEFAULT : 'default' ;
END_SWITCH : 'end switch' ;
PASS       : 'pass' ;

OPERATOR            : '+' 
                    | '-' 
                    | '*' 
                    | '/' 
                    | '%' ;
COMPARISON_OP  : '>' 
                    | '<' 
                    | '==' 
                    | '!=' 
                    | '>=' 
                    | '<=' ;
BOOLEAN             : 'true' | 'false' ;
INT       : DIGIT+ ;
STRING : '"' ( ~["\r\n\\] | '\\' . )* '"' ;

fragment LETTER    : 'a' .. 'z' | 'A' .. 'Z' | '_';  
fragment DIGIT     : '0' .. '9'; 
ID        : LETTER (LETTER | DIGIT)* ;  
LITERAL : INT
        | STRING
        | BOOLEAN ;
WS: [ \t\r\n]+ -> skip;
NEWLINE : '\r'? '\n' ;


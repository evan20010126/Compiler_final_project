%{
    #include "example2.tab.h"
    #include <stdio.h>
    #include <string.h>
%}


nonZeroNumber [1-9]+[0-9]*
variable [xyz]
functionName [A-Z]

%%

"+" {return ADD;}
"-" {return SUB;}
"=" {return ASSIGN;}
"|d" {return DERIVE;}

[+-]?[0-9]+ {yylval.intval = atoi(yytext); return NUMBER;}
\n {return EOL;}
[\t] {/*空白忽略*/}
" " {/*空白忽略*/}

"{"[+-]?(([0-9]*{variable}"^"{nonZeroNumber})("+"|"-"))*[0-9]*"}" {yylval.strval = strdup(yytext); return FUNCTION;}

"{"[+-]?(([0-9]*{variable}"^"{nonZeroNumber})("+"|"-"))*([0-9]*{variable}"^"{nonZeroNumber})"}" {yylval.strval = strdup(yytext); return FUNCTION;}

{functionName} {yylval.strval = strdup(yytext); return FUNCTIONNAME;}

{variable} {yylval.strval = strdup(yytext); return VAR;}

. {printf("非法字符%c\n",yytext);}




%%



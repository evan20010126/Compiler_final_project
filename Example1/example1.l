%{
    #include<stdio.h>
%}

%%
[0-9]+ {printf("%s: is a NUMBER\n", yytext);}
[a-zA-Z_][a-zA-Z_0-9]* {printf("%s: is an IDENTIFIER\n", yytext);}
.|\n {}
%%

int main(int argc, char* argv[]){
    yylex();
    return 0;
}
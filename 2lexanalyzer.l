%option noyywrap
%{
#include <stdio.h>
#include <string.h>
%}

%%
[ \t\n]+ ; // Ignore spaces, tabs, and new lines

"//"(.*) ; // Ignore single-line comments

"/*"([^*]|"*"+[^*/])*"*"+"/" ; // Ignore multi-line comments

[0-9]+ { printf("Integer: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* {
    if (strlen(yytext) <= 32) {
        printf("Identifier: %s\n", yytext);
    } else {
        printf("Identifier (Truncated): %.32s\n", yytext);
    }
}
[+\-*/=<>] { printf("Operator: %s\n", yytext); }
\"([^\\\"]|\\.)*\" { printf("String Literal: %s\n", yytext); }
. ; // Ignore other characters

%%

int main() {
    yylex();
    return 0;
}

%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
	/* integers */
[0-9]+	{
				yylval.i=atoi(yytext);
				return NUM;
			}

	/* operators */
[)(+*=\-/\n]	{
				yylval.i=*yytext;
				return *yytext;
			}
[\t]	;
			
.	yyerror("error");				
%%

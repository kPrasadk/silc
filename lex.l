%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
	/*variables*/
[a-z]		{
				return VAR;
			}	
	/* integers */
[0-9]+	{
				yylval.number=atoi(yytext);
				return NUM;
			}

	/* operators */
[)(+*=\-/\n]	{
				yylval.number=*yytext;
				return *yytext;
			}
[\t]	;
			
.	yyerror("error");				
%%

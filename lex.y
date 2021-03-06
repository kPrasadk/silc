%{
#include <stdio.h>
#include <string.h>
int sym[26];
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
		  printf("Exiting\n");
        return 1;
} 
  
 
main()
{
        yyparse();
} 

%}

%union
{
	char *text;
	int number;
}
  
%token NUM VAR
%left '+' '-'
%left '*' '/'
%type <text> expr
%type <number> NUM;
%%

program:
		program statement '\n'
		|
		;
		
statement:
		expr	{ printf("%s\n",$1);}
		;
				
expr:
		NUM {char num[40]; sprintf (num, "%d", $1); $$=strdup(num); }
		|
		expr '+' expr	{char rep[100]; sprintf (rep, "+ %s %s", $1, $3); $$=strdup(rep); }
		|
		expr '-' expr	{ char rep[100]; sprintf (rep, "- %s %s", $1, $3); $$=strdup(rep); }
		|
		expr '*' expr	{ char rep[100]; sprintf (rep, "* %s %s", $1, $3); $$=strdup(rep);  }
		|
		expr '/' expr	{ char rep[100]; sprintf (rep, "/ %s %s", $1, $3); $$=strdup(rep);  }
		|
		'(' expr ')'   { $$=$2;}
		;
%%


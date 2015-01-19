%{

typedef struct tree_node
{
	struct tree_node *left,*right;
	int val;
	char op;
}treenode;

#include <stdio.h>
#include <string.h>

treenode* make_node(char c,treenode *left,treenode *right,int v)
{
		treenode *node;
		node=malloc(sizeof(treenode));
		node->op=c;
		node->val=v;
		node->left=left;
		node->right=right;
		return node;
}

int evaluate(treenode *root)
{
		if(root->op!=' ')
		{
			switch(root->op)
			{
				case '+':
				return (evaluate(root->left)+evaluate(root->right)) ;
				case '-':
				return (evaluate(root->left)-evaluate(root->right)) ;
				case '*':
				return (evaluate(root->left)*evaluate(root->right)) ;
				case '/':
				return (evaluate(root->left)/evaluate(root->right)) ;
				default:
				printf("Will not reach here");
			}
		}
		else
			return root->val;
}
					 
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

%union {
			int i;
			struct tree_node *ptr;
		  };
		  
%token NUM 
%type <ptr> expr
%type <ptr> NUM
%left '+' '-'
%left '*' '/'

%%

program:
		program statement '\n'	
		|
		;
		
statement:
		expr	{ printf("%d\n",evaluate($1));}
		|
		;
				
expr:
		NUM				{ $$=make_node(' ',NULL,NULL,$1); }
		|
		expr '+' expr	{ $$=make_node('+',$1,$3,0); }
		|
		expr '-' expr	{ $$= make_node('-',$1,$3,0); }
		|
		expr '*' expr	{ $$=make_node('*',$1,$3,0); }
		|
		expr '/' expr	{ $$=make_node('/',$1,$3,0); }
		|
		'(' expr ')'   { $$=$2;}
		;
%%


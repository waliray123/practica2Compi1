%lex
%%

"Wison"                                             return 'WISON';
"Terminal"                                          return 'TERM_PAL';
"No_Terminal"                                       return 'NO_TERM_PAL';
"Syntax"                                            return 'SYNTAX';
"Lex"                                               return 'LEX';
"Initial_Sim"                                       return 'INITIAL_SIM';
"¿"                                                 return 'PREGI';
"?"                                                 return 'PREGD';
"{"                                                 return 'CORCHI';
"}"                                                 return 'CORCHD';
":"                                                 return 'DOS_PUNT';
";"                                                 return 'PUNT_COMA';
"*"                                                 return 'ASTER';
"+"                                                 return 'SUMA';
"("                                                 return 'PARI';
")"                                                 return 'PARD';
"<-"                                                return 'FLECHA';
"<="                                                return 'FLECHADOB';
"|"                                                 return 'BARRA_VERT';
\$_[a-zA-Z0-9_]+                                    return 'TERMINAL';
%_[a-zA-Z0-9_]+                                     return 'NO_TERMINAL';
"[aA-zZ]"                                           return 'ALFAB';
"[0-9]"                                             return 'TODOS_NUM';
\'([a-zA-Z0-9\[\]{}+\-*/:;¿?\%()#]|[!@$>\^,.])+\'   return 'CADENA';
#([a-zA-Z0-9\[\]{}+\-*/:;¿?\%()#_<>=]|[!@$>\^,.]|[ ])* {/*Comentario1*/}
\/\*\*([a-zA-Z0-9\[\]{}+\-*/:;¿?\%()#_<>=]|[!@$>\^,.]|[ \r\n])*\*\/ {/*Comentario2*/}
[ \r\t\b\f\n]+                                      {/*Blancos*/}
<<EOF>>                                             return 'EOF';
.                       {/*Error*/}

/lex

/* operator associations and precedence */

%start inicio

%%
inicio 
        :   WISON PREGI sig PREGD WISON        
;

sig 
        :   LEX CORCHI DOS_PUNT sigLex DOS_PUNT CORCHD sig
        |   SYNTAX CORCHI CORCHI DOS_PUNT sigSyntax DOS_PUNT CORCHD CORCHD sig
;

sigLex 
        :   TERM_PAL TERMINAL FLECHA cads PUNT_COMA sigLex
        |
;

cads 
        :   CADENA rex
        |   ALFAB rex
        |   TODOS_NUM rex
        |   PARI cads PARD cads
;

rex 
        :   ASTER
        |   SUMA
        |   PREGD
;

sigSyntax 
        :   NO_TERM_PAL NO_TERMINAL DOS_PUNT sigSyntax
        |   INITIAL_SIM NO_TERMINAL DOS_PUNT sigSyntax
        |   NO_TERMINAL FLECHADOB prod DOS_PUNT sigSyntax
        |
;

prod
        :   NO_TERM_PAL
        |   TERMINAL
        |   BARRA_VERT prod
        |
;

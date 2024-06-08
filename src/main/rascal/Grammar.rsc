module Grammar

layout Skip = [\t-\n\r\ ]*;

start syntax Program = tasks: Module* modulos;

// Definición de un módulo
syntax Module = modulec: "defmodule" Name "do" Function* "end";

// Definición de una función
syntax Function= func: "def" Name "(" ArgumentList? ")" "do" Statement* "end";

syntax Statement= varDecl: "var" Name "=" Expression ";"
                > assign: Name "=" Expression ";"
                > ifStmt: "if" Expression "do" Statement* "end"
                > caseStmt: "case" Expression "do" CaseClause+ "end"
                > receiveStmt: "receive" "do" ReceiveClause+ "end"
                > spawnStmt: (Name? Name "=")? "spawn" "(" Statement ")" ";"
                > sendStmt: "send" "(" Expression "," Expression ")" ";"?
                > anonFunDecl: "fn" "("? ArgumentList? ")"? "-\>" Statement* "end"
                > taskStmt: (Name? Name "=")? "Task.async" "(" Statement* ")" ";"?
                > taskAwaitStmt: (Name? Name "=")? "Task.await" "(" Statement* ")" ";"?
                > agentStartStmt: (Name? Name "=")? "Agent.start" "(" Statement* ")" ";"
                > agentUpdateStmt: (Name? Name "=")? "Agent.update" "(" Expression "," Statement* ")" ";"
                > agentGetStmt: (Name? Name "=")? "Agent.get" "(" Expression "," Statement* ")" ";"  
                > exprStmt: Expression ";"?
;

syntax Expression = ListExpr
                > TupleExpr
                > FunctionCall
                > Number
                > Name 
                > BinaryExpr: BinaryExpr  
                > String
                ;

// Definiciones para listas y tuplas
syntax ListExpr = "[" ":"? Expression ("," ":"? Expression)* "]";
syntax TupleExpr = "{" ":"? Expression ("," ":"? Expression)* "}";

// Llamada a función
syntax FunctionCall = call: Name "(" ArgumentList? ")";                
// Clausula de case
syntax CaseClause = clause: Expression "-\>" Statement+;
// Clausula de receive
syntax ReceiveClause = clause: Expression "-\>" Statement+; 
syntax BinaryExpr = Expression ("==" | "!=" | "\<" | "\>" | "\<=" | "\>=" | "+" | "-") Expression;
// Lista de parámetros para las funciones
syntax ArgumentList = args: Name ("," Name)*
                    > argsUndf: Name Name ("," Name Name)*;
// Definición de un nombre de función
lexical Name = [a-zA-Z_][a-zA-Z0-9_]* !>> [a-zA-Z0-9_];
// Definición de un número
lexical Number = [0-9]+;
lexical String = "\"" ![\"\n]* "\"";

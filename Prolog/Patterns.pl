
glider([
    [1,0,1], 
    [0,1,1], 
    [0,1,0]
]).

dart([
    [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0], 
    [0,0,0,0,0,0,1,0,1,0,0,0,0,0,0], 
    [0,0,0,0,0,1,0,0,0,1,0,0,0,0,0], 
    [0,0,0,0,0,0,1,1,1,0,0,0,0,0,0], 
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 
    [0,0,0,0,1,1,0,0,0,1,1,0,0,0,0], 
    [0,0,1,0,0,0,1,0,1,0,0,0,1,0,0], 
    [0,1,1,0,0,0,1,0,1,0,0,0,1,1,0], 
    [1,0,0,0,0,0,1,0,1,0,0,0,0,0,1], 
    [0,1,0,1,1,0,1,0,1,0,1,1,0,1,0]
]).

% lista de padroes e seus nome
patterns("Glider", P):- glider(P).
patterns("Dart", P):- dart(P).

% lista dos nomes dos padroes
% tome cuidado! deve corresponder aos nomes da funcao 'patterns'
patternsNames([
    "Glider", 
    "Dart"
]).
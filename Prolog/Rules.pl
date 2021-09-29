:- include('Screen.pl').

title( ["Seleciona alguma regra para ver sua exemplificação"]).

menu( [
    "1. Qualquer célula viva com menos de dois vizinhos vivos morre de solidão             ",
    "2. Qualquer célula viva com mais de três vizinhos vivos morre de superpopulação       ",
    "3. Qualquer célula com exatamente três vizinhos vivos se torna uma célula viva        ",
    "4. Qualquer célula com dois vizinhos vivos continua no mesmo estado na próxima geração"]).

commandsTable([
    " s / w - mover cursor  ",
    " f - selecionar        ",
    " q - Voltar"]).

printMenu(menuTab):-
title(T),
commandsTable(CT),
createScreenBuffer(width, height, emptyPxl, initialBuffer ),
createBufferFromStringMatrix(T, textoBuf),
createBufferFromStringMatrix(menuTab, menuBuf),
createBufferFromStringMatrix(CT, tableBuf),

renderCentralized(initialBuffer, textoBuf, 0, 0, tmp1),
renderCentralized(tmp1, menuBuf, 0, 10, tmp2),
renderInBuffer(tmp2, tableBuf, 1, 3, tmp3),
printScreen(tmp3).


printArrow([ _], _, List2):- List2 is [_].
printArrow([row|rest], 0, List2):- List2 is (' '+ row + ' <<<') | rest.
printArrow([row|rest], i, List2):- printArrow(rest, i-1,List3),
List2 is row | List3.


mainLoop(indix):-
    menu(M),
    first(primeiroExemplo),
    second(segundoExemplo),
    third(terceiroExemplo),
    fourth(quartoExemplo),
    printArrow(M, indix, pa),
    printMenu(pa),

    read(command),

    recalculate(command, indix, newIndix),

    outSelect(command, indix),
    loopDecision(command, indix).

recalculate('w', Indix, NewIndix):-  NewIndix = ((Indix-1) + 4) mod 4.
recalculate('s', Indix, NewIndix):-  NewIndix is ((Indix+1) + 4) mod 4.
recalculate(_, Indix, NewIndix):- NewIndix is Indix.

outSelect('f', 3):- printRuleFour.
outSelect('f', 2):- printRuleThree .
outSelect('f', 1):- printRuleTwo.
outSelect('f', 0):- printRuleOne.
outSelect(_, _):- write(' ').

loopDecision('q',_):- write(' ').
loopDecision(_, NewIndix):- mainLoop(NewIndix).















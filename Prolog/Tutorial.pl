:- include('Screen.pl').
:- include('Patterns.pl').
:- include('Rules.pl').

texto( [
    "                 O Game of Life é um autômato celular desenvolvido pelo matemático britânico John Horton Conway em 1970.",
    " ",
    "        Ele foi criado para reproduzir, através de regras simples, as alterações em grupos de seres vivos com o passar das gerações.",
    " ",
    " As regras definidas são aplicadas a cada nova geração, assim, a partir de um padão de células definida pelo jogador, percebem-se mudanças",
    "                              muitas vezes inesperadas a cada nova geração, variando de padrões fixos a caóticos.",
    " ",
    " ",
    " Neste modelo, a representação de células vivas é dada por pixels brancos, enquanto as células mortas são representadas por pixels pretos."]
).

menu( [
    "Quais são as regras?"  
    ]).

commandsTable( [
    " f - selecionar        ",
    " q - voltar            "]).

printMenu(menuTab):-
    texto(T),
    commandsTable(CT),
    pattern("Glider Flower", gf),
    createScreenBuffer(width, height, emptyPxl, initialBuffer ),
    createBufferFromStringMatrix(T, textoBuf),
    createBufferFromStringMatrix(menuTab, menuBuf),
    createBufferFromStringMatrix(CT, tableBuf),
    matrixToBuffer(gf, solidPxl, flowerBuf),

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
    printArrow(M, indix, pa),
    printMenu(pa),

    recalculate(command, indix, newIndix),

    loopDecision(command, indix).




recalculate('w', Indix, NewIndix):-  NewIndix = ((Indix-1) + 2) mod 2.
recalculate('s', Indix, NewIndix):-  NewIndix is ((Indix+1) + 2) mod 2.
recalculate(_, Indix, NewIndix):- NewIndix is Indix.

outSelect('f', 0):- mainRules.
outSelect(_, _):- write(' ').

loopDecision('q',_):- write(' ').
loopDecision(_, NewIndix):- mainLoop(NewIndix).

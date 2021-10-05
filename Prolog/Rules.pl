titleRules( ["Selecione alguma regra para ver sua exemplificação"]).

menuRules( [
    "1. Qualquer célula viva com menos de dois vizinhos vivos morre de solidão             ",
    "2. Qualquer célula viva com mais de três vizinhos vivos morre de superpopulação       ",
    "3. Qualquer célula com exatamente três vizinhos vivos se torna uma célula viva        ",
    "4. Qualquer célula com dois vizinhos vivos continua no mesmo estado na próxima geração"]).

commandsTableRules([
    " s / w - mover cursor  ",
    " f - selecionar        ",
    " q - Voltar"]).


printRules(MenuTab):-

    titleRules(TitleRules),
    commandsTableRules(CommandsTable),
    width(Width),
    height(Height),
    emptyPxl(EmptyPxl),

    createScreenBuffer(Width, Height, EmptyPxl, InitialBuffer),
    createBufferFromStringMatrix(TitleRules, TextoBuf),
    createBufferFromStringMatrix(MenuTab, MenuBuf),
    createBufferFromStringMatrix(CommandsTable, TableBuf),

    renderCentralized(TextoBuf, InitialBuffer, 0, 0, Tmp1),
    renderCentralized(MenuBuf, Tmp1, 10, 0, Tmp2),
    renderInBuffer(TableBuf, Tmp2, 3, 1, Tmp3),
    printScreen(Tmp3).


rulesLoop(Index):-

    menuRules(Menu),
    MaxIndex = 4,
    printArrow(Menu, Index, MenuTab),
    printRules(MenuTab),

    firstExplanation(FirstExplanation),
    firstPattern(First, FirstSn),
    secondExplanation(SecondExplanation),
    secondPattern(Second, SecondSnd),
    thirdExplanation(ThirdExplanation),
    thirdPattern(Third, ThirdSnd),
    fourthExplanation(FourthExplanation),
    fourthPattern(Fourth, FourthSnd),

    waitKey(['q','w','s','f'], Key),  
    
    (Key = 'w', NewIndex is((Index - 1) + MaxIndex) mod MaxIndex;
	 Key = 's', NewIndex is ((Index + 1) + MaxIndex) mod MaxIndex;
     Key = 'q', tutorial;
     Key = 'f', Index =:= 0, printExplanation(FirstExplanation, First, FirstSnd, 10);
     Key = 'f', Index =:= 1, printExplanation(SecondExplanation, Second, SecondSnd, 4);
     Key = 'f', Index =:= 2, printExplanation(ThirdExplanation, Third, ThirdSnd, 2);
     Key = 'f', Index =:= 3, printExplanation(FourthExplanation, Fourth, FourthSnd, 5)),
    
    rulesLoop(NewIndex).

rules:- rulesLoop(0).








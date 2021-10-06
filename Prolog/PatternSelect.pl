commandsTablePatternSelect([" s / w - mover cursor  ", 
                            " f - selecionar        "]).


printPatternSelect(MenuTab, Pattern):-

    width(Width),
    height(Height),
    emptyPxl(EmptyPxl),
    solidPxl(SolidPxl),
    commandsTablePatternSelect(CommandsTable),
    

    createScreenBuffer(Width, Height, EmptyPxl, InitialBuffer),
    createBufferFromStringMatrix(MenuTab, MenuBuf),
    createBufferFromStringMatrix(CommandsTable, TableBuf),
    matrixToBuffer(SolidPxl, Pattern, PatternBuf),

    renderCentralized(PatternBuf, InitialBuffer, 0, 10, Tmp1),
    renderInBuffer(MenuBuf, Tmp1, 8, 8, Tmp2),
    renderInBuffer(TableBuf, Tmp2, 3, 1, Tmp3),

    printScreen(Tmp3).

selectLoop(Mat, Index):-

    patternsNames(PatternsNames),
    MaxIndex = 23,
    printArrow(PatternsNames, Index, MenuTab),
    
    nth0(Index, PatternsNames, PatternName),
    pattern(PatternName,Pattern),

    printPatternSelect(MenuTab, Pattern),
    

    waitKey(['s','w','f'], Key),  
    
    (Key = 'w', NewIndex is ((Index - 1) + MaxIndex) mod MaxIndex;
	 Key = 's', NewIndex is ((Index + 1) + MaxIndex) mod MaxIndex;
     Key = 'f', patternLocate(Mat, Pattern)),
    
    selectLoop(Mat, NewIndex).
    
 patternSelect(Mat):- selectLoop(Mat, 0).


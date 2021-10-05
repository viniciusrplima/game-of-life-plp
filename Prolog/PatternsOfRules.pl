

firstPattern([[1]],[[0]]).

secondPattern([[0,0,0,0,0],
          [0,1,0,1,0],
          [0,0,1,0,0],
          [0,1,0,1,0],
          [0,0,0,0,0]],
          [[0,0,0,0,0],
          [0,0,1,0,0],
          [0,1,0,1,0],
          [0,0,1,0,0],
          [0,0,0,0,0]]).


thirdPattern([[0,0,0,0,0],
         [0,0,0,1,0],
         [0,0,1,0,0],
         [0,0,0,1,0],
         [0,0,0,0,0]],
         [[0,0,0,0,0],
         [0,0,0,0,0],
         [0,0,1,1,0],
         [0,0,0,0,0],
         [0,0,0,0,0]]).

fourthPattern([[0,0,0,0,0],
               [0,1,0,0,0],
               [0,0,1,0,0],
               [0,0,0,1,0],
               [0,0,0,0,0]],
              [[0,0,0,0,0],
               [0,0,0,0,0],
               [0,0,1,0,0],
               [0,0,0,0,0],
               [0,0,0,0,0]]).


firstExplanation(["Note que a célula da primeira geração deixa de estar viva na segunda, cumprindo com a regra."]).

secondExplanation(["Note que a célula que se encontra no meio do padrão na primeira geração, deixa de estar viva na segunda, cumprindo com a regra."]).

thirdExplanation(["Note que a célula não-viva que se encontra no meio das trẽs vivas na primeira geração, torna-se uma célula viva, cumprindo com a regra."]
).

fourthExplanation(["Note que a célula viva que se encontra no meio do padrão da primeira geração, continua na segunda, cumprindo com a regra."]).

firstText(["Primeira Geração:"]).
secondText(["Segunda Geração:"]).

commandsTablePatternsofRules([
    " q - Voltar"]).

printExplanation(Explanation, FirstRule, SecondRule, Position):-

    width(Width),
    height(Height),
    solidPxl(SolidPxl),
    emptyPxl(EmptyPxl),
    commandsTablePatternsofRules(CommandsTablePatternsofRules),
    firstText(FirstText),
    secondText(SecondText),
    
    
    createScreenBuffer(Width, Height, EmptyPxl, InitialBuffer),
    createBufferFromStringMatrix(CommandsTablePatternsofRules, TableBuf),
 
    matrixToBuffer(SolidPxl, FirstRule, MatrixBuf),   
    matrixToBuffer(SolidPxl, SecondRule, SecondMatrixBuf),

    
    createBufferFromStringMatrix(Explanation, ExplanationBuf),
    createBufferFromStringMatrix(FirstText, FirstTextBuf),
    createBufferFromStringMatrix(SecondText, SecondTextBuf),
    renderInBuffer(TableBuf, InitialBuffer,  3, 1, Tmp1),
    renderInBuffer(MatrixBuf, Tmp1, 10, 30, Tmp2),  
    renderInBuffer(ExplanationBuf, Tmp2, 30, Position, Tmp3),
    renderInBuffer(SecondMatrixBuf,Tmp3, 20, 30, Tmp4),
    renderInBuffer(FirstTextBuf, Tmp4, 10, 5, Tmp5),
    renderInBuffer(SecondTextBuf, Tmp5, 20, 5, Tmp6),
    printScreen(Tmp6),

    get_key(Key),
     (Position =:= 4, rulesLoop(1);
     Position =:= 2, rulesLoop(2);
     Position =:= 5, rulesLoop(3);
     Position =:= 10, rulesLoop(0)),


    printExplanation(Explanation, RulePattern, Position).

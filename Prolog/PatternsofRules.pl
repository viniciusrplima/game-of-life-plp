:- include('Screen.pl').




first([[1]],[[0]]).

second([[0,0,0,0,0],
          [0,1,0,1,0],
          [0,0,1,0,0],
          [0,1,0,1,0],
          [0,0,0,0,0]],
          [[0,0,0,0,0],
          [0,0,1,0,0],
          [0,1,0,1,0],
          [0,0,1,0,0],
          [0,0,0,0,0]]).


third([[0,0,0,0,0],
         [0,0,0,1,0],
         [0,0,1,0,0],
         [0,0,0,1,0],
         [0,0,0,0,0]],
         [[0,0,0,0,0],
         [0,0,0,0,0],
         [0,0,1,1,0],
         [0,0,0,0,0],
         [0,0,0,0,0]]).

fourth([[0,0,0,0,0],
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

secondExplanation( ["Note que a célula que se encontra no meio do padrão na primeira geração, deixa de estar viva na segunda, cumprindo com a regra."]).

thirdExplanation( ["Note que a célula não-viva que se encontra no meio das trẽs vivas na primeira geração, torna-se uma célula viva, cumprindo com a regra."]
).

fourthExplanation(["Note que a célula viva que se encontra no meio do padrão da primeira geração, continua na segunda, cumprindo com a regra."]).

tag(["Primeira Geração:"],
       ["Segunda Geração:"]).

comandsTable( [
    " q - Voltar"]).

printRuleOne():-
    first(fst),
    first(snd),
    tag(T),
    firstExplanation(forE),
    commandsTable(CT),
    createScreenBuffer(width, height, emptyPxl, initialBuffer ),
    createBufferFromStringMatrix(CT, tableBuf),
    matrixToBuffer(fst, solidPxl, matrixBuf),
    matrixToBuffer(snd, solidPxl, sndMatrixBuf),
    createBufferFromStringMatrix(forE, explanationBuf),
    createBufferFromStringMatrix(T, fstText),
    createBufferFromStringMatrix(T, sndText),

    renderInBuffer(initialBuffer, tableBuf, 1, 3, tmp1),
    renderInBuffer(tmp1, matrixBuf, 30, 10, tmp2),
    renderInBuffer(tmp2, explanationBuf, 10, 30, tmp3),
    renderInBuffer(tmp3, sndMatrixBuf, 30, 20, tmp4),
    renderInBuffer(tmp4, fstText, 5, 10, tmp5),
    renderInBuffer(tmp5, sndText, 5, 20, tmp6),
    printScreen(tmp6),

    read(command),

    (command = 'q'; printRuleOne ).




printRuleTwo():-
    second(fst),
    second(snd),
    tag(T),
    secondExplanation(forE),
    commandsTable(CT),
    createScreenBuffer(width, height, emptyPxl, initialBuffer ),
    createBufferFromStringMatrix(CT, tableBuf),
    matrixToBuffer(fst, solidPxl, matrixBuf),
    matrixToBuffer(snd, solidPxl, sndMatrixBuf),
    createBufferFromStringMatrix(forE, explanationBuf),
    createBufferFromStringMatrix(T, fstText),
    createBufferFromStringMatrix(T, sndText),

    renderInBuffer(initialBuffer, tableBuf, 1, 3, tmp1),
    renderInBuffer(tmp1, matrixBuf, 30, 10, tmp2),
    renderInBuffer(tmp2, explanationBuf, 4, 30, tmp3),
    renderInBuffer(tmp3, sndMatrixBuf, 30, 20, tmp4),
    renderInBuffer(tmp4, fstText, 5, 10, tmp5),
    renderInBuffer(tmp5, sndText, 5, 20, tmp6),
    printScreen(tmp6),

    read(command),

    (command = 'q'; printRuleTwo ).


printRuleThree():-
    third(fst),
    third(snd),
    tag(T),
    thirdExplanation(forE),
    commandsTable(CT),
    createScreenBuffer(width, height, emptyPxl, initialBuffer ),
    createBufferFromStringMatrix(CT, tableBuf),
    matrixToBuffer(fst, solidPxl, matrixBuf),
    matrixToBuffer(snd, solidPxl, sndMatrixBuf),
    createBufferFromStringMatrix(forE, explanationBuf),
    createBufferFromStringMatrix(T, fstText),
    createBufferFromStringMatrix(T, sndText),

    renderInBuffer(initialBuffer, tableBuf, 1, 3, tmp1),
    renderInBuffer(tmp1, matrixBuf, 30, 10, tmp2),
    renderInBuffer(tmp2, explanationBuf, 2, 30, tmp3),
    renderInBuffer(tmp3, sndMatrixBuf, 30, 20, tmp4),
    renderInBuffer(tmp4, fstText, 5, 10, tmp5),
    renderInBuffer(tmp5, sndText, 5, 20, tmp6),
    printScreen(tmp6),

    read(command),

    (command = 'q'; printRuleThree ).

printRuleFour():-
    fourth(fst),
    fourth(snd),
    tag(T),
    fourthExplanation(forE),
    commandsTable(CT),
    createScreenBuffer(width, height, emptyPxl, initialBuffer ),
    createBufferFromStringMatrix(CT, tableBuf),
    matrixToBuffer(fst, solidPxl, matrixBuf),
    matrixToBuffer(snd, solidPxl, sndMatrixBuf),
    createBufferFromStringMatrix(forE, explanationBuf),
    createBufferFromStringMatrix(T, fstText),
    createBufferFromStringMatrix(T, sndText),

    renderInBuffer(initialBuffer, tableBuf, 1, 3, tmp1),
    renderInBuffer(tmp1, matrixBuf, 30, 10, tmp2),
    renderInBuffer(tmp2, explanationBuf, 5, 30, tmp3),
    renderInBuffer(tmp3, sndMatrixBuf, 30, 20, tmp4),
    renderInBuffer(tmp4, fstText, 5, 10, tmp5),
    renderInBuffer(tmp5, sndText, 5, 20, tmp6),
    printScreen(tmp6),

    read(command),

    (command = 'q'; printRuleFour ).



















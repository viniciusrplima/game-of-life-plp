
commandsTableLocate([
    " f - adicionar             ", 
    " a - esquerda              ", 
    " d - direita               ", 
    " w - cima                  ", 
    " s - baixo                 ", 
    " r - rotacionar a direita  ", 
    " l - rotacionar a esquerda ", 
    " q - cancelar              "]).

patternLocateRec(InitialMat, Pattern, Col, Row):-
    screenSize(W, H), 

    mergeMatrixHighlight(Pattern, InitialMat, Col, Row, Mat), 
    commandsTableLocate(Table), 
    createBufferFromStringMatrix(Table, TableBuf), 
    matrixToBufferHighlight(Mat, MatBuf), 

    renderInBuffer(TableBuf, MatBuf, 5, 5, Tmp1), 
    printScreen(Tmp1),

    waitKey(['w','s','f','a','d','r','l','q'], Key),  

    ( Key = 'f', mergeMatrix(Pattern, InitialMat, Col, Row, NewMat), matrixViewLoop(NewMat);
      Key = 'q', matrixViewLoop(InitialMat);
      Key = 'a', NCol is ((Col-1) mod W), patternLocateRec(InitialMat, Pattern, NCol, Row);
      Key = 'd', NCol is ((Col+1) mod W), patternLocateRec(InitialMat, Pattern, NCol, Row);
      Key = 'w', NRow is ((Row-1) mod W), patternLocateRec(InitialMat, Pattern, Col, NRow);
      Key = 's', NRow is ((Row+1) mod W), patternLocateRec(InitialMat, Pattern, Col, NRow);
      Key = 'r', rotateMatrixRight(Pattern, RPtn), patternLocateRec(InitialMat, RPtn, Col, Row);
      Key = 'l', rotateMatrixLeft(Pattern, RPtn), patternLocateRec(InitialMat, RPtn, Col, Row);
      patternLocateRec(InitialMat, Pattern, Col, Row)), !.

patternLocate(Mat, Pattern):- patternLocateRec(Mat, Pattern, 10, 10).

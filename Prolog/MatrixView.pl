:- include('Screen.pl').
:- include('Gol.pl').
:- include('Patterns.pl').

matrixCmdTable([
    " f - avancar                    ", 
    " c - limpar matrix              ", 
    " s - selecionar padrão          ", 
    " q - voltar para o menu inicial "]).

printMatrixView(Mat):-
    solidPxl(SPxl), 
    matrixToBuffer(SPxl, Mat, Buf), 

    matrixCmdTable(CmdTable), 
    createBufferFromStringMatrix(CmdTable, CmdBuf), 

    renderInBuffer(CmdBuf, Buf, 5, 5, Tmp1), 

    printScreen(Tmp1).

matrixViewLoop(Mat):-
    printMatrixView(Mat),
    advanceMatrix(Mat, NewMat), 
    get_key(Key),

    ( Key = 'q', main;
      Key = 'f', matrixViewLoop(NewMAt);
      Key = 's', writeln("pagina de selecao");
      Key = 'c', screenSize(W, H), createEmptyMatrix(W, H, EmpMat), matrixViewLoop(EmpMat);
      matrixViewLoop(NewMat)), !.

matrixView:- 
    screenSize(W, H), 
    createEmptyMatrix(W, H, Mat), 
    pattern("Glider", Dart), 
    mergeMatrix(Dart, Mat, 10, 20, Final), 
    matrixViewLoop(Final).


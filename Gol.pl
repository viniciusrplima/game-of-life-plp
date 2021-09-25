:- include('Utils.pl').
:- use_module(library(clpfd)).

% ****************************
%  MATRIX
% ****************************

liveCell(1).
deadCell(0).
otherCell(2). % usado para diferenciar celulas

% cria matriz vazia
createEmptyMatrix(W, H, Mat):-
    deadCell(C),
    replicate(C, W, Row), 
    replicate(Row, H, Mat).

matrixSize(Mat, W, H):-
    nth0(0, Mat, FRow), 
    length(FRow, W), 
    length(Mat, H).

% verifica se a posicao eh valida
isValidPosition(Mat, Col, Row):-
    matrixSize(Mat, W, H), 
    Col >= 0, 
    Col < W, 
    Row >= 0, 
    Row < H.

% return current state of the cell
currentState(Mat, ICol, IRow, Cell):-    
    matrixSize(Mat, W, H),
    NCol is ICol mod W, 
    NRow is IRow mod H, 
    nth0(NRow, Mat, Row), 
    nth0(NCol, Row, Cell).

% conta se a celula esta viva ou morta
% se estiver viva retorna 1
% se estiver morta ou esta for uma posicao invalida retorna 0
countLive(Mat, ICol, IRow, R):-
    currentState(Mat, ICol, IRow, Cell), 
    doCountLive(Cell, R).

doCountLive(Cell, 1):- liveCell(Cell).
doCountLive(_, 0).

% conta o numero total de vizinhos de uma celula
countNeighbors(Mat, Col, Row, R):-
    countLive(Mat, Col-1, Row  , S1), 
    countLive(Mat, Col-1, Row-1, S2), 
    countLive(Mat, Col-1, Row+1, S3), 
    countLive(Mat, Col,   Row-1, S4), 
    countLive(Mat, Col,   Row+1, S5), 
    countLive(Mat, Col+1, Row  , S6), 
    countLive(Mat, Col+1, Row-1, S7), 
    countLive(Mat, Col+1, Row+1, S8),
    R is S1 + S2 + S3 + S4 + S5 + S6 + S7 + S8, !.

% calcula o proximo estado de uma celula
calculateNextCellState(Mat, Row, Col, NextState):-
    countNeighbors(Mat, Col, Row, Neighbors), 
    currentState(Mat, Col, Row, State), 
    doCalculateNextCellState(State, Neighbors, NextState), !.

doCalculateNextCellState(State, Neighbors, NextState):- 
    liveCell(State), 
    Neighbors < 2, 
    deadCell(NextState).
doCalculateNextCellState(State, Neighbors, NextState):- 
    liveCell(State), 
    Neighbors > 2, 
    deadCell(NextState).
doCalculateNextCellState(State, Neighbors, NextState):- 
    deadCell(State), 
    Neighbors =:= 3, 
    liveCell(NextState).
doCalculateNextCellState(State, _, State).

% atualiza matriz e retorna seu proximo estado
advanceMatrix(Mat, R):-
    matrixSize(Mat, _, H), 
    range(0, H, Indices), 
    maplist(advanceMatrixRow(Mat), Indices, R), !.

advanceMatrixRow(Mat, Row, R):-
    matrixSize(Mat, W, _), 
    range(0, W, Indices), 
    maplist(calculateNextCellState(Mat, Row), Indices, R), !.

% ****************************
%  OPERATIONS
% ****************************

% junta duas matrizes em uma
mergeMatrix([], Tgt, _, _, Tgt). 
mergeMatrix(_, [], _, _, []).
mergeMatrix([SH|Src], [TH|Tgt], Col, 0, R):-
    mergeMatrixRow(SH, TH, Col, MRow), 
    mergeMatrix(Src, Tgt, Col, 0, Rest), 
    append([MRow], Rest, R), !.
mergeMatrix(Src, [TH|Tgt], Col, Row, R):- 
    NRow is Row - 1, 
    mergeMatrix(Src, Tgt, Col, NRow, Rest), 
    append([TH], Rest, R), !.

mergeMatrixRow([], Tgt, _, Tgt).
mergeMatrixRow(_, [], _, []).
mergeMatrixRow([SH|Src], [_|Tgt], 0, R):-
    mergeMatrixRow(Src, Tgt, 0, Rest), 
    append([SH], Rest, R), !.
mergeMatrixRow(Src, [TH|Tgt], Col, R):- 
    NCol is Col - 1, 
    mergeMatrixRow(Src, Tgt, NCol, Rest), 
    append([TH], Rest, R), !.

% junta duas matrizes centralizadas
mergeMatrixCentralized(Src, Tgt, R):-
    matrixSize(Src, SW, SH), 
    matrixSize(Tgt, TW, TH), 
    Col is TW // 2 - SW // 2, 
    Row is TH // 2 - SH // 2, 
    mergeMatrix(Src, Tgt, Col, Row, R).

% junta duas matrizes de forma que as celulas das duas fiquem 
mergeMatrixHighlight(Mat, Tgt, Col, Row, R):-
    transformCellsToHighlight(Tgt, HTgt), 
    mergeMatrixHLOverlap(Mat, HTgt, Col, Row, R).

mergeMatrixHLOverlap(_, [], _, _, []).
mergeMatrixHLOverlap([], Tgt, _, _, Tgt).
mergeMatrixHLOverlap([SH|Src], [TH|Tgt], Col, 0, R):-
    mergeMatrixHighlightRow(SH, TH, Col, MRow), 
    mergeMatrixHLOverlap(Src, Tgt, Col, 0, Rest), 
    append([MRow], Rest, R).
mergeMatrixHLOverlap(Src, [TH|Tgt], Col, Row, R):-
    NRow is Row - 1, 
    mergeMatrixHLOverlap(Src, Tgt, Col, NRow, Rest), 
    append([TH], Rest, R).

mergeMatrixHighlightRow(_, [], _, []).
mergeMatrixHighlightRow([], Tgt, _, Tgt).
mergeMatrixHighlightRow([SH|Src], [TH|Tgt], 0, R):-
    mergeCellHighlight(SH, TH, HCell), 
    mergeMatrixHighlightRow(Src, Tgt, 0, Rest), 
    append([HCell], Rest, R).
mergeMatrixHighlightRow(Src, [TH|Tgt], Col, R):- 
    NCol is Col - 1, 
    mergeMatrixHighlightRow(Src, Tgt, NCol, Rest), 
    append([TH], Rest, R).

mergeCellHighlight(A, _, R):- not(deadCell(A)), liveCell(R).
mergeCellHighlight(_, B, R):- not(deadCell(B)), otherCell(R).
mergeCellHighlight(_, _, R):- deadCell(R).

% transform liveCells into otherCells
transformCellsToHighlight(Mat, R):- maplist(transformCellsToHighlightRow, Mat, R), !.
transformCellsToHighlightRow(MatRow, R):- maplist(transformCellsToHighlightCell, MatRow, R).
transformCellsToHighlightCell(MatCell, R):- liveCell(MatCell), otherCell(R).
transformCellsToHighlightCell(MatCell, MatCell).

% rotaciona matriz para a esquerda
rotateMatrixRight(Mat, R):- reverse(Mat, Tmp), transpose(Tmp, R).

% rotaciona matriz para a direita
rotateMatrixLeft(Mat, R):- transpose(Mat, Tmp), reverse(Tmp, R).
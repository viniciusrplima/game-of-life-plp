:- include('Utils.pl').

% largura do pixel
% numero de caracteres por pixel
pixelWidth(2).

% largura do terminal
termWidth(W):- tty_size(W,_).

% altura do terminal
termHeight(H):- tty_size(_,H).

% largura da tela em pixels
width(X) :- 
    termWidth(TW),
    pixelWidth(PW), 
    X is div(TW, PW).

% altura da tela em pixels
height(Y) :- termHeight(Y).

% cria um pixel a partir de um character
pixel(C, X) :- 
    pixelWidth(PW),
    replicate(C, PW, L),
    atomic_list_concat(L, X).

% pixels padroes
emptyPxl(' ').
shadowPxl('░').
solidPxl('█').

% *****************************
%   BUFFERS
% *****************************

% cria um buffer a partir da largura, da altura e do conteudo do pixel
createScreenBuffer(W, H, C, Buf) :-
    pixel(C, Pxl),
    replicate(Pxl, W, Row), 
    replicate(Row, H, Buf).


% *****************************
%   SCREEN
% *****************************

% imprime buffer na tela
printScreen(Buf):-
    maplist(atomic_list_concat, Buf, RowList),
    atomic_list_concat(RowList, '\n', BufStr),
    write(BufStr).

% retorna o tamanho da maior linha
bufferWidth(Buf, W):- 
    maplist(length, Buf, Ls), 
    max_list(Ls, W).

% retorna o numero de linhas
bufferHeight(Buf, H):- length(Buf, H).

% renderiza um buffer dentro do outro
renderInBuffer(_, [], _, _, []):- !.
renderInBuffer([], Tgt, _, _, Tgt):- !.
renderInBuffer([SRow|Scr], [TRow|Tgt], 0, Col, R):-
    renderInBufferRow(SRow, TRow, Col, RRow), 
    renderInBuffer(Scr, Tgt, 0, Col, Rest), 
    append([RRow], Rest, R), !.
renderInBuffer(Src, [TRow|Tgt], Row, Col, R):- 
    NR is Row - 1, 
    renderInBuffer(Src, Tgt, NR, Col, Rest),
    append([TRow], Rest, R), !.

renderInBufferRow(_, [], _, []):- !.
renderInBufferRow([], Tgt, _, Tgt):- !.
renderInBufferRow([SPxl|Scr], [_|Tgt], 0, R):-
    renderInBufferRow(Scr, Tgt, 0, Rest), 
    append([SPxl], Rest, R), !.
renderInBufferRow(Scr, [TPxl|Tgt], Col, R):-
    NC is Col - 1, 
    renderInBufferRow(Scr, Tgt, NC, Rest), 
    append([TPxl], Rest, R), !.

% cria um buffer a partir de uma matrix de strings
createBufferFromStringMatrix(Matrix, Buf):-
    maplist(stringToBufferRow, Matrix, Buf).

stringToBufferRow("", []):- !.
stringToBufferRow(Text, RowList):-
    pixelWidth(PW), 
    string_length(Text, TL), 
    TL >= PW, 
    sub_string(Text, 0, PW, _, Pxl), 
    sub_string(Text, PW, _, 0, StrRest), 
    stringToBufferRow(StrRest, Rest), 
    append([Pxl], Rest, RowList), !.
stringToBufferRow(Text, RowList):-
    pixelWidth(PW), 
    string_length(Text, TL), 
    Comp is PW - TL, 
    create_string(' ', Comp, CompStr), 
    atom_concat(Text, CompStr, CompText), 
    stringToBufferRow(CompText, RowList).

% ****************************
%   GOL UTILS
% ****************************

matrixToBuffer(PixelContent, Matrix, Buffer):-
    maplist(matrixToBufferRow(PixelContent), Matrix, Buffer), !.

matrixToBufferRow(PixelContent, MatRow, BufRow):-
    maplist(createPixelFromGolCell(PixelContent), MatRow, BufRow).

createPixelFromGolCell(PixelContent, 1, Pixel):- pixel(PixelContent, Pixel).
createPixelFromGolCell(_, _, Pixel):- pixel(" ", Pixel).
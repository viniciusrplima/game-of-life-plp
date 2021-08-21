:- include('Utils.pl').

pixelWidth(2).

termWidth(100).
termHeight(40).

width(X) :- 
    termWidth(TW),
    X is div(TW, 2).

height(Y) :- 
    termHeight(TH),
    Y is div(TH, 2).

% cria um pixel a partir de um character
pixel(C, X) :- 
    pixelWidth(PW),
    replicate(C, PW, L),
    atomic_list_concat(L, X).

% pixels padroes
emptyPxl(X) :- pixel(' ', X).
shadowPxl(X) :- pixel('░', X).
solidPxl(X) :- pixel('█', X).

% *****************************
%   BUFFERS
% *****************************

% cria um buffer a partir da largura, da altura e do conteudo do pixel
createScreenBuffer(W, H, C, Buf) :-
    pixel(C, Pxl),
    replicate(Pxl, W, Row), 
    replicate(Row, H, Buf).

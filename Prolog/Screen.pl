:- include('Utils.pl').

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

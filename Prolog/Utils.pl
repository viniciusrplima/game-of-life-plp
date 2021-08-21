
% replica um elemento em uma lista
replicate(X, N, L) :-
    length(L, N),
    maplist(=(X), L).
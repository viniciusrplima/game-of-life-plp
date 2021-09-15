
% replica um elemento em uma lista
replicate(X, N, L) :-
    length(L, N),
    maplist(=(X), L).

create_string(X, N, Str):- 
    replicate(X, N, L),
    atomic_list_concat(L, Str).
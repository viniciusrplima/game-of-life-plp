
% replica um elemento em uma lista
replicate(X, N, L) :-
    length(L, N),
    maplist(=(X), L).

range(A, A, []).
range(A, B, R):-
    NA is A + 1, 
    range(NA, B, Rest), 
    append([A], Rest, R).

create_string(X, N, Str):- 
    replicate(X, N, L),
    atomic_list_concat(L, Str).

waitKey(ValidKeys, ReturnedKey) :-
    get_single_char(X),
    char_code(Y, X),
    (member(Y, ValidKeys) ->
    ReturnedKey = Y;
    waitKey(ValidKeys, K), ReturnedKey = K).


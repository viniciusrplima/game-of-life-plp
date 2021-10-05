
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

get_key(X):-
    ttyflush, 
    get_single_char(Y), 
    atom_char(X, Y).


printArrow([],_,[]).
printArrow([Row|Rest],I,R):-
    (I =:= 0, 
     string_concat(Row," <<<",X),
     string_concat(" ", X, Z),
     R = [Z|Rest];
     N is I-1,
     I >=0,
     printArrow(Rest, N, Z),
     R = [Row|Z]).
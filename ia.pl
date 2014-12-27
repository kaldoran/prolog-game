%% Author : Reynaud Nicolas

eval(Board, Valeur, Pawn) :-
    invert_player(Pawn, EnemiPawn),
    findall(Pawn, member(Pawn, Board), ResultP), 
    findall(EnemiPawn, member(EnemiPawn, Board), ResultE), 
    Valeur is length(ResultP) - length(ResultE).
    
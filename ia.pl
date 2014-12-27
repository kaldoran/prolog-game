%% Author : Reynaud Nicolas

eval(Board, Valeur, Pawn) :-
    invert_player(Pawn, EnemiPawn),
    findall(Pawn, member(Pawn, Board), ResultP), 
    findall(Pawn, member(Pawn, Board), ResultE), 
    LP is Length(ResultP),
    LE is Length(ResultE),
    Valeur is LP - LE.
%% Author : Reynaud Nicolas

eval(Board, Valeur, Pawn) :-
    invert_player(Pawn, EnemiPawn),
    findall(Pawn, member(Pawn, Board), ResultP), 
    findall(EnemiPawn, member(EnemiPawn, Board), ResultE), 
    queen(Pawn, QueenP),
    queen(EnemiPawn, QueenE),
    findall(QueenP, member(QueenP, Board), ResultPQ),
    findall(QueenE, member(QueenE, Board), ResultEQ),
    length(ResultP, LP),
    length(ResultE, LE), 
    length(ResultPQ, LPQ),
    length(ResultEQ, LEQ), 
    TotalP is LP + LPQ,
    TotalE is LE + LEQ,
    ( 
        iPlay(' x '), 
            ( Pawn = ' x ' -> 
                Valeur is TotalP - TotalE; 
                Valeur is -(TotalE - TotalP)
            )
        ;
        iPlay(' o '), 
            ( Pawn = ' o ' -> 
                Valeur is TotalP - TotalE; 
                Valeur is -(TotalE - TotalP)
            )
    ).

minmax(Board, Pawn, Depth) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    seekMoves(Board, BlankSpace, Pawn, Depth).



seekMoves(_, _, _, 0).
seekMoves(Board, [To|BlankSpace], Pawn, Depth) :-
    findall(Place, existValideEat(Board, Place, Between, To, ' x '), ResultEat),
    findall(Place, existValide(Board, Place, To, ' x ', Result),
    applyMoves(Board, ResultEat, To, MaxVal, Pawn, Depth),
    applyMoves(Board, Result, To, MaxVal, Pawn, Depth),
    seekMoves(NewBoard, BlankSpace, Pawn, Depth).

applyMoves(Board, [], _, MaxVal, _, _).
applyMoves(Board, [From|Result], To, MaxVal, Pawn, Depth) :-
    NewDepth is Depth - 1,
    move(Board, From, To, Pawn, NewBoard),
    eval(Board, Valeur, Pawn),
    minmax(NewBoard, Pawn, NewDepth),
    ( Valeur > MaxValue -> 
        applyMoves(Board, Result, To, Valeur, Pawn, Depth);
        applyMoves(Board, Result, To, MaxValue, Pawn, Depth)
    ).
    
%% findall(Place, nth1(Place, Board, '   '), BlankSpace).
%% findall(Place, existValideEat(Board, Place, Between, To, ' x '), ' x ').
%% Et findall(Place, existValide(Board, Place, To, ' x '), ' x ').
%% Donne la liste des coups
%% To depuis BlankSpace

%% Puis : Essai move depuis valideMove
%% Calcul
%% Best of Calcule

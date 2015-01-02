%% Author : Reynaud Nicolas

eval(Board, Valeur, Pawn) :-
    isEndGame(Board, Winner),
    ( 
        iPlay(Pawn),
        Winner = Pawn,
        Valeur = 100;
        Valeur = -100
    ).

    
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
    
% On cherche tout les coup, pour ce faire on cherche les cases vides

max(A, B, A) :-
    A >= B, !.
max(_, B, B).

min(A, B, A) :-
    B >= A, !.
min(_, B, B).

findPlay(Board, Pawn, Depth, From, To) :-

    minmax(Board, Pawn, Depth, Eval, From, To), write(Eval).

minmax(Board, Pawn, 0, Eval, _, _) :-
    eval(Board, Eval, Pawn).
   
minmax(Board, Pawn, Depth, Eval, From, To) :-
    true.
        
applyMoves(Board, [From|Result], To, MaxVal, Pawn, Depth, From) :-
    NewDepth is Depth - 1,
    move(Board, From, To, Pawn, NewBoard),
    minmax(NewBoard, Pawn, NewDepth, From, To),
    ( Valeur > MaxValue -> 
        applyMoves(Board, Result, To, Valeur, Pawn, Depth);
        applyMoves(Board, Result, To, MaxValue, Pawn, Depth)
    ).
    
    
    
findAllMove(Board, Pawn, AllMoves) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    seekMoves(Board, BlankSpace, Pawn, AllMoves).

seekMoves(_, [], _, []).
seekMoves(Board, [To|BlankSpace], Pawn, AllMoves) :-
    findall(Place, existValideEat(Board, Place, Between, To, Pawn), ResultEat),
    findall(Place, existValide(Board, Place, To, Pawn), ResultValide),
    allMoves(ResultValide, To, AllMovesValide),
    allMoves(ResultEat, To, AllMovesEat),
    append(AllMovesValide, AllMovesEat, AllMovesGlobale),
    seekMoves(Board, BlankSpace, Pawn, AllMovesSeek),
    append(AllMovesGlobale, AllMovesSeek, AllMoves).

allMoves([], _, []).
allMoves([From|Result], To, [[From, To]|AllMoves]) :-
    allMoves(Result, To, AllMoves).
    
%% Puis : Essai move depuis valideMove
%% Calcul
%% Best of Calcule


    


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

minmax(Board, Pawn, Depth) :-
    applyMoves(Board, [], _, MaxVal, Pawn, 0).
    
minmax(Board, Pawn, Depth) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    seekMoves(Board, BlankSpace, Pawn, Depth).


% Cherche et effectue tout les coup possibles    
seekMoves(Board, [To|BlankSpace], Pawn, Depth) :-
    findall(Place, existValideEat(Board, Place, Between, To, Pawn), ResultEat),
    findall(Place, existValide(Board, Place, To, Pawn, Result), Result),
    applyMoves(NewBoard, ResultEat, To, MaxVal, Pawn, Depth),
    applyMoves(NewBoard, Result, To, MaxVal2, Pawn, Depth),

applyMoves(Board, [], _, MaxVal, Pawn, 0) :- 
    eval(Board, Eval, Pawn),
    ( 
        iPlay(Pawn),
        max(Eval, MaxVal);
        min(Eval, MaxVal)
    ).
        
applyMoves(Board, [From|Result], To, MaxVal, Pawn, Depth) :-
    NewDepth is Depth - 1,
    move(Board, From, To, Pawn, NewBoard),
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

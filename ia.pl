%% Author : Reynaud Nicolas (Kaldoran)

%% evalEndGame is called for give the Eval of and ending point
%% According to the '+Pawn'
%% ----------------------------------------------------------- %%
evalEndGame(100, Pawn) :-
    iPlay(Pawn), !.
    
evalEndGame(-100, _).

eval(Board, Value, Pawn) :-
    isX(Pawn),
    findall(X, (member(X, Board), isX(X)), ResultX),
    findall(O, (member(O, Board), isO(O)), ResultO),
    length(ResultX, LRX),
    length(ResultO, LRO),
    Value is LRX - LRO, !.
    
eval(Board, Value, Pawn) :-
    isO(Pawn),
    findall(X, (member(X, Board), isX(X)), ResultX),
    findall(O, (member(O, Board), isO(O)), ResultO),
    length(ResultX, LRX),
    length(ResultO, LRO),
    Value is LRO - LRX, !.
        

%% Return best Move
%% ---------------- %
seekMax(_, [BestMove], BestMove) :- !.
seekMax([X, Y|Eval], [_|AllMoves], BestMove) :-
    X > Y, seekMax([X|Eval], AllMoves, BestMove), !.
seekMax([_, Y|Eval], [A, _|AllMoves], BestMove) :-
    seekMax([Y|Eval], [A|AllMoves], BestMove).
    
 
findPlay(Board, Pawn, Depth, BestMove) :-
    findAllMove(Board, Pawn, AllMoves),
    simulate(Board, Pawn, AllMoves, Depth, Eval),
    seekMax(Eval, AllMoves, BestMove), !.

simulate(_, _, [], _, []) :- !.
simulate(Board, Pawn, [Move|AllMoves], Depth, [EvalBis|Eval]) :-
    multiMove(Board, Move, Pawn, NewBoard),
    NewDepth is Depth - 1,
    invert_player(Pawn, EnemyPawn),
    (
        iPlay(Pawn), min(NewBoard, EnemyPawn, NewDepth, EvalBis);       %% If its the human turn to simulate

        max(NewBoard, EnemyPawn, NewDepth, EvalBis)
    ),
    simulate(Board, Pawn, AllMoves, Depth, Eval).


min(Board, Pawn, 0, Eval) :-
    eval(Board, Eval, Pawn), !.

min(Board, _, _, Eval) :-
    isEndGame(Board, Winner),
    evalEndGame(Eval, Winner), !.

min(Board, Pawn, Depth, Eval) :-
    findAllMove(Board, Pawn, AllMoves),
    simulate(Board, Pawn, AllMoves, Depth, EvalList),
    min_list(EvalList, Eval).

max(Board, Pawn, 0, Eval) :-
    eval(Board, Eval, Pawn), !.
    
max(Board, _, _, Eval) :-
    isEndGame(Board, Winner),
    evalEndGame(Eval, Winner).

max(Board, Pawn, Depth, Eval) :-
    findAllMove(Board, Pawn, AllMoves),
    simulate(Board, Pawn, AllMoves, Depth, EvalList), 
    max_list(EvalList, Eval).


findAllMove(Board, Pawn, AllMoves) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    seekMoves(Board, BlankSpace, Pawn, AllMoves).

seekMoves(_, [], _, []).
seekMoves(Board, [To|BlankSpace], Pawn, AllMoves) :-
    findall([Place, Between], existValideEat(Board, Place, Between, To, Pawn), ResultEat),
    findall(Place, existValide(Board, Place, To, Pawn), ResultValide),
    allMovesVal(ResultValide, To, AllMovesValide),
    allMovesEat(Board, Pawn, ResultEat, To, AllMovesEat),
    append(AllMovesValide, AllMovesEat, AllMovesGlobale),
    seekMoves(Board, BlankSpace, Pawn, AllMovesSeek),
    append(AllMovesGlobale, AllMovesSeek, AllMoves), !.

allMovesEat(_, _, [], _, []).

allMovesEat(Board, Pawn, [[From, Between]|Result], To, All) :-
    multiMove(Board, [[From, Between, To]], Pawn, NewBoard),
    seekMultiMove(NewBoard, To, Pawn, MultiMove),
    append([[From, Between, To]], MultiMove, MultiEat),
    allMovesEat(Board, Pawn, Result, To, AllMoves), 
    append(AllMoves, [MultiEat], All), !.


seekMultiMove(Board, From, Pawn, [[From, Between, To]|MultiMove]) :-
    existValideEatFrom(Board, From, Between, To, Pawn),
    multiMove(Board, [[From, Between, To]], Pawn, NewBoard),
    seekMultiMove(NewBoard, To, Pawn, MultiMove).
    
seekMultiMove(_, _, _, []).

allMovesVal([], _, []).
allMovesVal([From|Result], To, [[From, To]|AllMoves]) :-
    allMovesVal(Result, To, AllMoves).
    

    
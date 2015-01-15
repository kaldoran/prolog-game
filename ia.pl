%% Author : Reynaud Nicolas (Kaldoran)

%% evalEndGame is called for give the Eval of and ending point
%% According to the '+Pawn'
%% ----------------------------------------------------------- %%
evalEndGame(100, Pawn) :-
    iPlay(Pawn), !.
    
evalEndGame(-100, _).

%% Evaluate the '+Board' according to the '+Pawn'
%% And output the evaluation of the board in '-Value'
%% ------------------------------------------------- %%
eval(Board, Value, Pawn, 1) :-
    isX(Pawn),
    findall(X, (member(X, Board), isX(X)), ResultX),
    findall(O, (member(O, Board), isO(O)), ResultO),
    length(ResultX, LRX),
    length(ResultO, LRO),
    Value is LRX - LRO, !.
    
eval(Board, Value, Pawn, 1) :-
    isO(Pawn),
    findall(X, (member(X, Board), isX(X)), ResultX),
    findall(O, (member(O, Board), isO(O)), ResultO),
    length(ResultX, LRX),
    length(ResultO, LRO),
    Value is LRO - LRX, !.

eval(Board, Value, Pawn, 2) :- 
    valueBoard(Board, 1, Value, Pawn).

eval(Board, Value, Pawn, 3) :-
    isX(Pawn),
    findAllRaid(Pawn, Board, ResultRX),
    findAllRaid((X, isO(X)), Board, ResultRO),
    Value is ResultRX - ResultRO, !.
    
eval(Board, Value, Pawn, 3) :-
    isO(Pawn),
    findAllRaid(Pawn, Board, ResultRX),
    findAllRaid((O, isO(O)), Board, ResultRO),
    Value is ResultRO - ResultRX, !.
    
%% Evaluate the '+Board' according to the sqares' values
%% And output the evaluation of the board in '-Value'
%% ----------------------------------------------------- %%
valueBoard([Sqr], _, 0, _):- 
    \+isPawn(Sqr),!.    
    
valueBoard([Sqr], _, 6, Pawn):-
    isSameColor(Sqr,Pawn), !.
    
valueBoard([_], _, -10, _):-!.
valueBoard([Sqr|RestBoard], Pos, Value, Pawn):- 
    \+isPawn(Sqr),Pos2 is Pos + 1, 
    valueBoard(RestBoard, Pos2, Value, Pawn), !.
    
valueBoard([Sqr|RestBoard], Pos, Value, Pawn):-
    isSameColor(Sqr,Pawn),Pos2 is Pos + 1, 
    valueSqr(Pos,ValueSqr), 
    valueBoard(RestBoard, Pos2, Value2, Pawn), 
    Value is Value2 + ValueSqr, !.
    
valueBoard([_|RestBoard], Pos, Value, Pawn):-
    Pos2 is Pos + 1,
    valueBoard(RestBoard, Pos2, Value2, Pawn),
    Value is Value2 - 10,!.

%% Associate values to the squares
%% ------------------------------- %%
valueSqr(Pos,6):-
    member(Pos,[2,4,6,8,10,91,93,95,97,99]),!.
    
valueSqr(Pos,5):-
    member(Pos,[11,30,31,50,51,70,71,90]),!.
    
valueSqr(Pos,4):-
    member(Pos,[13,15,17,19,22,39,42,59,62,79,82,84,86,88]),!.
    
valueSqr(Pos,3):-
    member(Pos,[24,26,28,33,48,53,68,73,75,77]),!.
    
valueSqr(Pos,2):-
    member(Pos,[35,37,44,57,64,66]),!.
    
valueSqr(Pos,1):-
    member(Pos,[46,55]).
        

%% Look for the max of '+Eval' and '+AllMove'
%% Matching the '+Eval' best move with his '+AllMove' move
%% And put it into '-BestMove'
%% ------------------------------------------------------- %%
seekMax(_, [BestMove], BestMove) :- !.
seekMax([X, Y|Eval], [_|AllMoves], BestMove) :-
    X > Y, seekMax([X|Eval], AllMoves, BestMove), !.
seekMax([_, Y|Eval], [A, _|AllMoves], BestMove) :-
    seekMax([Y|Eval], [A|AllMoves], BestMove).
    
 
%% Look on the '+Board' with the '+Pawn' whats the '-BestMove' to do
%% In a '+Depth' according to a minmax function
%% ----------------------------------------------------------------- %%
findPlay(Board, Pawn, Depth, BestMove, AI) :-
    findAllMove(Board, Pawn, AllMoves),
    simulate(Board, Pawn, AllMoves, Depth, Eval, AI),
    seekMax(Eval, AllMoves, BestMove),!.

%% Simulate a '+Move' on a '+Board' 
%% with the '+Pawn' and complete the '-Eval'
%% ----------------------------------------- %%
simulate(_, _, [], _, [], _) :- !.

simulate(Board, Pawn, [Move|AllMoves], Depth, [EvalBis|Eval], AI) :-
    multiMove(Board, Move, NewBoard),
    NewDepth is Depth - 1,
    invert_player(Pawn, EnemyPawn),
    (
        iPlay(Pawn), min(NewBoard, EnemyPawn, NewDepth, EvalBis, AI);       %% If its the human turn to simulate

        max(NewBoard, EnemyPawn, NewDepth, EvalBis, AI)
    ),
    simulate(Board, Pawn, AllMoves, Depth, Eval, AI).

%% Min on the '+Board'
%% Simulate a move on the '+Board' 
%% ------------------------------ %%
min(Board, Pawn, 0, Eval, AI) :-
    eval(Board, Eval, Pawn, AI), !.

min(Board, _, _, Eval, _) :-
    isEndGame(Board, Winner),
    evalEndGame(Eval, Winner), !.

min(Board, Pawn, Depth, Eval, AI) :-
    findAllMove(Board, Pawn, AllMoves),
    simulate(Board, Pawn, AllMoves, Depth, EvalList, AI),
    min_list(EvalList, Eval).

%% Max part of the minmax 
%% ---------------------- %%
max(Board, Pawn, 0, Eval, AI) :-
    eval(Board, Eval, Pawn, AI), !.
    
max(Board, _, _, Eval, _) :-
    isEndGame(Board, Winner),
    evalEndGame(Eval, Winner).

max(Board, Pawn, Depth, Eval, AI) :-
    findAllMove(Board, Pawn, AllMoves),
    simulate(Board, Pawn, AllMoves, Depth, EvalList, AI), 
    max_list(EvalList, Eval).


%% Find all available move for a '+Pawn'
%% on the '+Board' and complet the '-AllMoves'
%% ------------------------------------------ %%
findAllMove(Board, Pawn, AllMoves) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    findAllQueenMoves(Board, Pawn, AllQueenMoves, BlankSpace),
    seekMoves(Board, BlankSpace, Pawn, AllRegularMoves),
    append(AllRegularMoves, AllQueenMoves, AllMoves).

%% Predicate that actually found all the move
%% ------------------------------------------ %%
seekMoves(_, [], _, []).
seekMoves(Board, [To|BlankSpace], Pawn, AllMoves) :-
    findall([Place, Between], existValideEat(Board, Place, Between, To, Pawn), ResultEat),
    findall(Place, existValide(Board, Place, To, Pawn), ResultValide),
    allMovesVal(ResultValide, To, AllPawnMoves),
    allMovesEat(Board, Pawn, ResultEat, To, AllMovesEat),
    append(AllPawnMoves, AllMovesEat, AllMovesGlobale),
    seekMoves(Board, BlankSpace, Pawn, AllMovesSeek),
    append(AllMovesGlobale, AllMovesSeek, AllMoves), !.

%% Look for allMove 
%% then appply them and complet the '-All' result  
%% ---------------------------------------------- %%
allMovesEat(_, _, [], _, []).

allMovesEat(Board, Pawn, [[From, Between]|Result], To, All) :-
    multiMove(Board, [[From, Between, To]], NewBoard),
    seekMultiMove(NewBoard, To, Pawn, MultiMove),
    append([[From, Between, To]], MultiMove, MultiEat),
    allMovesEat(Board, Pawn, Result, To, AllMoves), 
    append(AllMoves, [MultiEat], All), !.

%% Look for all move after a given move
%% ------------------------------------ %%
seekMultiMove(Board, From, Pawn, [[From, Between, To]|MultiMove]) :-
    existValideEatFrom(Board, From, Between, To, Pawn),
    multiMove(Board, [[From, Between, To]], NewBoard),
    seekMultiMove(NewBoard, To, Pawn, MultiMove).
    
seekMultiMove(_, _, _, []).

%% Complet the '-AllMoves' array
%% ----------------------------- %%
allMovesVal([], _, []).
allMovesVal([From|Result], To, [[From, To]|AllMoves]) :-
    allMovesVal(Result, To, AllMoves).
    
findAllQueenMoves(Board, Pawn, AllQueenMoves, BlankSpace) :-
    queen(Pawn, Queen),
    findall(Place, nth(Place, Board, Queen), AllQueen),
    allMovesQueen(Board, AllQueen, BlankSpace, Queen, AllQueenMoves).
    
allMovesQueen(_, [], _, _, []) :- !.
allMovesQueen(Board, [From|AllQueen], BlankSpace, Queen, AllQueenMoves) :-
    seekAllMovesQueen(Board, From, BlankSpace, Queen, AllQMoves),
    append(AllQMoves, AQM, AllQueenMoves), 
    allMovesQueen(Board, AllQueen, BlankSpace, Queen, AQM).

seekAllMovesQueen(_, _, [], _, []) :- !.
seekAllMovesQueen(Board, From, [To|BlankSpace], Queen, [[From, To]|AllQueenMoves]) :-
    Distance is abs(From - To),
    (
        mod(Distance, 11) =:= 0;
        
        mod(Distance, 9) =:= 0
    ),
    isValideSpecial(Board, From, To, Queen),
    seekAllMovesQueen(Board, From, BlankSpace, Queen, AllQueenMoves), !.
    
seekAllMovesQueen(Board, From, [To|BlankSpace], Queen, [[[From, Between, To]]|AllQueenMoves]) :-
    Distance is abs(From - To),
    (
        mod(Distance, 11) =:= 0;
        
        mod(Distance, 9) =:= 0
    ),
    isValideEat(Board, From, Between, To, Queen),
    seekAllMovesQueen(Board, From, BlankSpace, Queen, AllQueenMoves), !.
    
seekAllMovesQueen(Board, From, [_|BlankSpace], Queen, AllQueenMoves) :- 
    seekAllMovesQueen(Board, From, BlankSpace, Queen, AllQueenMoves).   

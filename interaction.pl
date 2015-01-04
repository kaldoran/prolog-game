%% Author : Reynaud Nicolas

askMove(From, To, Board, PlayPawn) :-
	write('From - To [Row, Column] - [Row, Column] ? '),
	read(RowColumnFrom - RowColumnTo), 
	convert(RowColumnFrom, From), 
	convert(RowColumnTo, To), 
	writeDebug(' Square N° [+1 Cause nth need +1]: '), writeDebug(From), write(' - '), writeDebug(To), nl, 
	check(RowColumnFrom, From, Board, PlayPawn),
	check(RowColumnTo, To, Board, '   '). 

askMove(From, To, Board, PlayPawn) :-
    write('[WARNING] : Illegal Move. Play Again !'), nl,
	askMove(From, To, Board, PlayPawn).
	
askEndMove :-
    write('Do you have any extra move ? [y]es or [N]o or [e]xit.'), nl,
    read(Answer),
    ( Answer = 'y', true; Answer = 'e', halt; fail).
    
	
%% ---------------------------------------------------------------------- %%
%% Avant de faire le move, si e pion arrivera sur le bord, faire une dame %%
%% ---------------------------------------------------------------------- %%

multiMove(Board, [], _, Board).

multiMove(Board, [From, To|MultiMove], Pawn, NewBoard) :-
    move(Board, From, To, Pawn, TmpBoard),
    multiMove(TmpBoard, MultiMove, Pawn, NewBoard).

multiMove(Board, [[From, Between, To]|MultiMove], Pawn, NewBoard) :-
    move(Board, From, To, Pawn, TmpBoard),
    removePawn(TmpBoard, Between, TmpBoardBis),
    multiMove(TmpBoardBis, MultiMove, Pawn, NewBoard).

move(Board, From, To, Pawn, NewBoard) :-
	( To >= 90; To =< 10),
	queen(Pawn, Queen),
	doMove(Board, From, To, Queen, NewBoard).
	
move(Board, From, To, Pawn, NewBoard) :-
    doMove(Board, From, To, Pawn, NewBoard).
    
% Ensuite on peut faire le move
doMove([], _, _, _, []).
	
doMove([_|Board], 1, To, Pawn, ['   '|NewBoard]) :-
	NewTo is To - 1,
	doMove(Board, 0, NewTo, Pawn, NewBoard), !.
doMove([_|Board], From, 1, Pawn, [Pawn|NewBoard]) :-
	NewFrom is From - 1,
	doMove(Board, NewFrom, 0, Pawn, NewBoard), !.
doMove([X|Board], From, To, Pawn, [X|NewBoard]) :-
	NewFrom is From - 1,
	NewTo is To - 1,
	doMove(Board, NewFrom, NewTo, Pawn, NewBoard).
	
%% --------------- %%
%% Retirer un pion %%
%% --------------- %%
removePawn(Board, Square, NewBoard) :-
	move(Board, Square, 0, '   ',NewBoard).
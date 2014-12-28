%% Author : Reynaud Nicolas

askMoveFrom(From, Board, Pawn) :-
	write('From '),
	askMove(From, Board, Pawn).

askMoveFrom(From, Board, Pawn) :-
	nl, write('[WARNING] : Illegal Move. Play Again !'), nl,
	askMoveFrom(From, Board, Pawn).

askMoveTo(To, Board, _) :-
	write('To '),
	askMove(To, Board, '   ').

askMoveTo(To, Board, _) :-
	nl, write('[WARNING] : Illegal Move. Play Again !'), nl,
	askMoveTo(To, Board, '   ').

askMove(Square, Board, PlayPawn) :-
	write('[Row, Column] ? '),
	read(RowColumn), 
	convert(RowColumn, Square), 
	writeDebug(' Square N° [+1 Cause nth need +1]: '), writeDebug(Square), nl, 
	check(RowColumn, Square, Board, PlayPawn). 

askEndMove :-
    write('Do you have any extra move ? [y]es or [N]o or [e]xit.'), nl,
    read(Answer),
    ( Answer = 'y', true; Answer = 'e', halt; fail).
    
	
%% ---------------------------------------------------------------------- %%
%% Avant de faire le move, si e pion arrivera sur le bord, faire une dame %%
%% ---------------------------------------------------------------------- %%

move(Board, From, To, Pawn, NewBoard) :-
	( To >= 90; To =< 10),
	queen(Pawn, Queen),
	doMove(Board, From, To, Queen, NewBoard), !.
	
move(Board, From, To, Pawn, NewBoard) :-
    doMove(Board, From, To, Pawn, NewBoard).
    
% Ensuite on peut faire le move
doMove([], _, _, _, _) :- !.
doMove([_|Board], 1, To, Pawn, ['   '|NewBoard]) :-
	NewTo is To - 1,
	doMove(Board, 0, NewTo, Pawn, NewBoard), !.
doMove([_|Board], From, 1, Pawn, [Pawn|NewBoard]) :-
	NewFrom is From - 1,
	move(Board, NewFrom, 0, Pawn, NewBoard), !.
doMove([X|Board], From, To, Pawn, [X|NewBoard]) :-
	NewFrom is From - 1,
	NewTo is To - 1,
	doMove(Board, NewFrom, NewTo, Pawn, NewBoard).
	
%% --------------- %%
%% Retirer un pion %%
%% --------------- %%
removePawn(Board, Square, NewBoard) :-
	move(Board, Square, 0, '   ',NewBoard).
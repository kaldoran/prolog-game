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
	
%% ---------------------------------------------------------------------- %%
%% Avant de faire le move, si e pion arrivera sur le bord, faire une dame %%
%% ---------------------------------------------------------------------- %%
%% BESOIN D UN REWORK SUR CA.

% move(Board, From, To, Pawn, NewBoard) :-
%	NewBoard is [],
%	( Pawn = ' x '-> To >= 90; To =< 10),
%	queen(Pawn, Queen),
%	move(Board, From, To, Queen, NewBoard).

% Ensuite on peut faire le move
move([], _, _, _, _) :- !.
move([_|Board], 1, To, Pawn, ['   '|NewBoard]) :-
	NewTo is To - 1,
	move(Board, 0, NewTo, Pawn, NewBoard), !.
move([_|Board], From, 1, Pawn, [Pawn|NewBoard]) :-
	NewFrom is From - 1,
	move(Board, NewFrom, 0, Pawn, NewBoard), !.
move([X|Board], From, To, Pawn, [X|NewBoard]) :-
	NewFrom is From - 1,
	NewTo is To - 1,
	move(Board, NewFrom, NewTo, Pawn, NewBoard).
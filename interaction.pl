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
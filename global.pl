debug('yes').

writeDebug(X) :-
	debug('yes'),
	write(X).

isPawn(' x ').
isPawn(' o ').
isPawn(' O ').
isPawn(' X ').

isQueen(' O ').
isQueen(' X ').

isBlack(' n ').
isEmpty('   ').

startGame :-
	initialize_game(Board),
	printBoard(Board),
	write('From '),
	askMove(From),
	write('To '),
	askMove(To),
	nth1(From, Board, Value),
	move(Board, From, To, Value, NewBoard),
	printBoard(NewBoard),
	isEndGame(NewBoard, _).

isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	member(Looser, Board), !.

addPawn(Board, To, Pawn, NewBoard) :-
	move(Board, 0, To, Pawn, NewBoard).

replaceByQueen(Board, Square, Pawn, NewBoard) :-
	queen(Pawn, Queen),
	move(Board, Square, Square, Queen, NewBoard).

move([], _, _, _, _) :- !.
move([_|Board], 1, To, Pawn, ['   '|NewBoard]) :-
	NewTo is To - 1,
	move(Board, 0, NewTo, Pawn, NewBoard).
move([_|Board], From, 1, Pawn, [Pawn|NewBoard]) :-
	NewFrom is From - 1,
	move(Board, NewFrom, 0, Pawn, NewBoard).
move([X|Board], From, To, Pawn, [X|NewBoard]) :-
	NewFrom is From - 1,
	NewTo is To - 1,
	move(Board, NewFrom, NewTo, Pawn, NewBoard).

% Ask a move to the player and check it
askMove(Square) :-
	write('[Row, Column] ? '),
	read(RowColumn), check(RowColumn), 
	convert(RowColumn, Square), 
	writeDebug(' Square N° [+1 Cause nth need +1]:'), writeDebug(Square), 
	nl.

check([Row, Column]) :-
	checkColumn(Column),
	checkRow(Row).

checkColumn(Column) :-
	Column > 0,
	Column =< 10.

checkRow(Row) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	char_code('k', CodeI),
	CodeA =< Code,
	CodeI > Code, !.

convert([Row, Column], Square) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	RowMove is Code - CodeA,
	Square is RowMove * 10 + Column.

% the grid
initialize_game([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ', ' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ', ' w ',
			 	  ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ', ' x ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ', ' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ', '   ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ', ' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ', ' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ', ' w '
				 ] ).

% Print the grid of Pawn
printBoard(Board) :-	
	write('  | 1   2   3   4   5   6   7   8   9   10|'), nl,
	printCase,
	printLine(Board, 'a').

printCase :-
	write('  |---|---|---|---|---|---|---|---|---|---|'), nl.

% Stop when all line had been display
printLine(_, 'i') :- !.

% Print a Line of the board
printLine(Board, Line) :- 
	write(Line), write(' |'),
	printLinePawn(Board, Line, 0).

% Call the print of the next line
printLinePawn(Board, Line, 10) :- 
	nl, printCase,
	char_code(Line, Code), 
	NewCode is Code + 1, 
	char_code(NewChar, NewCode),
	printLine(Board, NewChar), !.

% Print a line Pawn by Pawn
printLinePawn([X|L], Line, Pawn) :-
	write(X),
	write('|'),
	NewPawn is Pawn + 1,
	printLinePawn(L, Line, NewPawn).
	
% Invert the current player
invert_player(' x ', ' o ').
invert_player(' o ', ' x ').

% Transforme a Pawn into Queen Pawn
queen(' o ', ' O ').
queen(' x ', ' X ').

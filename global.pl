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
	askMove(Square),
	nth1(Square, Board, Value),
	write('Value of Square : '), write(Value),
	isEndGame(Board, Winner).

isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	member(Looser, Board), !.

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
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ', ' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ', '   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ', ' w '
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

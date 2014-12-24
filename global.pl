debug('yes').

writeDebug(X) :-
	debug('yes'),
	write(X).

isPawn(' x ').
isPawn(' o ').
isBlack(' n ').
isEmpty('   ').

startGame :-
	initialize_game(Board),
	printBoard(Board),
	askMove.

% Ask a move to the player and check it
askMove :-
	write('[Column, Row] ? '),
	read(ColumnRow), check(ColumnRow), nl.

check([Column, Row]) :-
	checkColumn(Column),
	checkRow(Row).

checkColumn(Column) :-
	writeDebug(Column),
	Column > 0,
	Column < 9.


checkRow(Row) :-
	writeDebug(Row),
	char_code(Row, Code),
	char_code('a', CodeA),
	char_code('i', CodeI),
	CodeA =< Code,
	Code > CodeI, !.

% the grid
initialize_game([ ' n ',' x ',' n ',' x ',' n ',' x ',' n ',' x ',
				  ' x ',' n ',' x ',' n ',' x ',' n ',' x ',' n ',
			 	  ' n ',' x ',' n ',' x ',' n ',' x ',' n ',' x ',
				  '   ',' n ','   ',' n ','   ',' n ','   ',' n ',
				  ' n ','   ',' n ','   ',' n ','   ',' n ','   ',
				  ' o ',' n ',' o ',' n ',' o ',' n ',' o ',' n ',
				  ' n ',' o ',' n ',' o ',' n ',' o ',' n ',' o ',
				  ' o ',' n ',' o ',' n ',' o ',' n ',' o ',' n '
				 ] ).

% Print the grid of Pawn
printBoard(Board) :-	
	write('  | 1   2   3   4   5   6   7   8 |'), nl,
	write('  |---|---|---|---|---|---|---|---|'), nl,
	printLine(Board, 'a'),
	write('  |-------------------------------|'), nl.


% Stop when all line had been display
printLine(_, 'i') :- !.

% Print a Line of the board
printLine(Board, Line) :- 
	write(Line), write(' |'),
	printLinePawn(Board, Line, 8).

% Call the print of the next line
printLinePawn(Board, Line, 0) :- 
	nl,
	char_code(Line, Code), 
	NewCode is Code + 1, 
	char_code(NewChar, NewCode),
	printLine(Board, NewChar), !.

% Print a line Pawn by Pawn
printLinePawn([X|L], Line, Pawn) :-
	write(X),
	write('|'),
	NewPawn is Pawn - 1,
	printLinePawn(L, Line, NewPawn).
	
% Invert the current player
invert_player('x', 'o').
invert_player('o', 'x').

% Transforme a Pawn into Queen Pawn
queen('o', 'O').
queen('x', 'X').

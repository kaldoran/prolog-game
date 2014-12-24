startGame :-
	initialize_game(Board),
	printBoard(Board),
	askColumn,
	askRow.

askColumn :-
	write('Column ? '),
	read(Column), checkColumn(Column), nl.

askRow :-
	write('Row ? '),
	read(Row), checkRow(Row), nl.
	
checkColumn(Column) :-
	Column > 0,
	Column < 9.


checkRow(Row) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	char_code('i', CodeI),
	CodeA =< Code,
	Code > CodeI, !.

checkRow(Row) :-
	char_code(Row, Code),
	char_code('A', CodeA),
	char_code('I', CodeI),
	CodeA =< Code,
	Code > CodeI.


initialize_game([ n , x , n , x , n , x , n , x ,
				  x , n , x , n , x , n , x , n ,
			 	  n , x , n , x , n , x , n , x ,
				  '  ', n ,' ', n ,' ', n ,' ', n ,
				  n ,' ', n ,' ', n ,' ', n ,' ',
				  o , n , o , n , o , n , o , n ,
				  n , o , n , o , n , o , n , o ,
				  o , n , o , n , o , n , o , n 
				 ] ).

printBoard(Board) :-	
	write('  | 1   2   3   4   5   6   7   8 |'), nl,
	write('  |---|---|---|---|---|---|---|---|'), nl,
	printLine(Board, 'A'),
	write('  |-------------------------------|'), nl.

printLine(_, 'I') :- !.
printLine(Board, Line) :-
	char_code(Line, Code) ,
	write(Line), write(' |'),
	printLinePawn(Board, Line, 8), nl,
	NewCode is Code + 1,
	char_code(NewChar, NewCode),
	printLine(Board, NewChar).


printLinePawn(_, _, 0) :- !.
printLinePawn(Board, _, Pawn) :- 
	write(' x |'),
	NewPawn is Pawn - 1,
	printLinePawn(Board, _, NewPawn).
	

invert_player('x', 'o').
invert_player('o', 'x').

king('o', 'O').
king('x', 'X').

%% Author : Reynaud Nicolas

%% ----------------------------- %%
%% Affichage de la grille de jeu %%
%% ----------------------------- %%
printBoard(Board) :-	
	write('  | 1   2   3   4   5   6   7   8   9   10|'), nl,
	printCase,
	printLine(Board, 'a').

printCase :-
	write('  |---|---|---|---|---|---|---|---|---|---|'), nl.

% Stop when all line had been display
printLine(_, 'k') :- !.

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
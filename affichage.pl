%% Author : Reynaud Nicolas (Kaldoran)

% Print the '+Board'
% ------------------ %
printBoard(Board) :-
	writeDebug(Board), nl,	
	write('  | 1   2   3   4   5   6   7   8   9   10|'), nl,
	printCase,
	printLine(Board, 'a').

% Print a Line
% ------------ %
printCase :-
	write('  |---|---|---|---|---|---|---|---|---|---|'), nl.

% Stop the newt letter is 'k'
% -------------------------- %
printLine(_, 'k') :- !.

% Print a Line of the '+Board'
% '+Line' is the number of the line
% --------------------------------- %
printLine(Board, Line) :- 
	write(Line), write(' |'),
	printLinePawn(Board, Line, 0).

% Call the print of the next line when the line is end
% ---------------------------------------------------- %
printLinePawn(Board, Line, 10) :- 
	nl, printCase,
	char_code(Line, Code), 
	NewCode is Code + 1, 
	char_code(NewChar, NewCode),
	printLine(Board, NewChar), !.

% Print a line Pawn by Pawn
% ------------------------- %
printLinePawn([X|L], Line, Pawn) :-
	write(X),
	write('|'),
	NewPawn is Pawn + 1,
	printLinePawn(L, Line, NewPawn).
	
printFT(From, To) :-
    revertConvert([RowFrom, ColumnFrom], From),
    revertConvert([RowTo, ColumnTo], To),
    write('Move From : ['),
    write(RowFrom),
    write(','),
    write(ColumnFrom),
    write('] To : ['),
    write(RowTo),
    write(','),
    write(ColumnTo), nl.
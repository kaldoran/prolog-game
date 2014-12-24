debug('no').

writeDebug(X) :-
	debug('yes'),
	write(X).

writeDebug(_).

isPawn(X) :-
	isRegularPawn(X); isQueen(X).

isRegularPawn(' x ').
isRegularPawn(' o ').
isQueen(' O ').
isQueen(' X ').

isBlack(' n ').
isEmpty('   ').

playX :-
	initialize_game(Board),
	play(Board, ' x ').

playO :-
	initialize_game(Board),
	play(Board, ' o ').

play(Board, _) :-
	isEndGame(Board, Winner),
	write('The Winner Is : '),
	write(Winner).

play(Board, Pawn) :-
	printBoard(Board),
	write('Time to play : '), write(Pawn), nl,
	askMoveFrom(From, Board, Pawn),
	askMoveTo(To, Board, Pawn),
	nth1(From, Board, Value),
	(isValide(Board, From, To, Pawn), move(Board, From, To, Value, NewBoard);
	isValideEat(Board, From, Between, To, Pawn), removePawn(Board, Between, TmpBoard), move(TmpBoard, From, To, Value, NewBoard)),
	invert_player(Pawn, NewPawn),
	play(NewBoard, NewPawn).


%% -------------------------- %%
%% Verification de fin du jeu %%
%% -------------------------- %%
isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	(member(Looser, Board), !, fail; true).


%% --------------- %%
%% Ajouter un pion %%
%% --------------- %%
addPawn(Board, To, Pawn, NewBoard) :-
	move(Board, 0, To, Pawn, NewBoard).

%% --------------- %%
%% Retirer un pion %%
%% --------------- %%
removePawn(Board, Square, NewBoard) :-
	move(Board, Square, 0, '   ',NewBoard).

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

%% ------------------------------- %%
%% Verification du l action joueur %%
%% ------------------------------- %%
isValide(Board, From, To) :-
	From \== To,
	nth1(From, Board, Pawn),
	isRegularPawn(Pawn),
	nth1(To, Board, '   '),
	isValide(Board, From, To, Pawn).

isValide(_, From, To, ' x ') :-
	To is From + 11, !; % 10 + 1 Diagonal bas droite
	To is From + 9, !.  % 10 - 1 Diagonal bas gauche

isValide(_, From, To, ' o ') :-
	To is From - 11, !; % Diagonal haut gauche
	To is From - 9, !.  % Diagonal haut droite

isValideEat(Board, From, Between, To, Pawn) :-
	(Between is From + 11; 
	Between is From + 9; 
	Between is From - 11;
	Between is From - 9),
	invert_player(Pawn, Enemi),
	nth1(Between, Board, Enemi),
	isValide(Board, Between, To, Pawn).


%% ------------------------------------- %%
%% Ask a move to the player and check it %%
%% ------------------------------------- %%

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

%% ------------------------------------- %%
%% Check if the movement is on the board %%
%% ------------------------------------- %%
check([Row, Column], Square, Board, PlayPawn) :-
	checkColumn(Column),
	checkRow(Row),
	nth1(Square, Board, Pawn),
	PlayPawn = Pawn.

checkColumn(Column) :-
	Column > 0,
	Column =< 10.

checkRow(Row) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	char_code('k', CodeI),
	CodeA =< Code,
	CodeI > Code, !.

%% --------------------------------------------- %%
%% Convert column and Row into the square number %%
%% --------------------------------------------- %%
convert([Row, Column], Square) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	RowMove is Code - CodeA,
	Square is RowMove * 10 + Column.

% the grid
initialize_game([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	  ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				 ] ).

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
	
% Invert the current player
invert_player(' x ', ' o ').
invert_player(' o ', ' x ').

% Transforme a Pawn into Queen Pawn
queen(' o ', ' O ').
queen(' x ', ' X ').

isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	(member(Looser, Board), !, fail; true).
	
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
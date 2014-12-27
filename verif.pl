%% Author : Reynaud Nicolas

isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	(member(Looser, Board), !, fail; true).
	
	
%% -------------------------------- %%
%% Verification Dame - A TRAVAILLER %%
%% -------------------------------- %%
isValide(_, To, To, Pawn) :-
    isQueen(Pawn), !.

isValide(Board, From, To, Pawn) :-
     \+ mod(To, From) =:= 0, !, fail.
    
isValide(Board, From, To, Pawn) :-
    FromBis is From + 11,    
    nth1(FromBis, Board, '   '),
    isValide(_, FromBis, To, Pawn), !.
    
isValide(Board, From, To, Pawn) :-
    FromBis is From + 9,
    nth1(FromBis, Board, '   '),
    isValide(_, FromBis, To, Pawn), !.
    
isValide(Board, From, To, Pawn) :-
    FromBis is From - 9,
    nth1(FromBis, Board, '   '),
    isValide(_, FromBis, To, Pawn), !.
    
isValide(Board, From, To, Pawn) :-
    FromBis is From - 11,
    nth1(FromBis, Board, '   '),
    isValide(_, FromBis, To, Pawn), !.
%% -------------------------------- %%
    
%% ------------------------------- %%
%% Verification du l action joueur %%
%% ------------------------------- %%

isValide(Board, From, To, Pawn) :-
    isRegularPawn(Pawn),
	From \== To,
	nth1(From, Board, Pawn),
	nth1(To, Board, '   ').
	
isValide(_, From, To, ' x ') :-
	isValideBR(_, From, To, ' x '); 
	isValideBL(_, From, To, ' x ').
	
isValide(_, From, To, ' o ') :-
	isValideTR(_, From, To, ' o '); 
	isValideTL(_, From, To, ' o ').
	
%%
%% 10 + 1 Diagonal bas droite
%%
isValideBR(_, From, To, Pawn) :- 
    (isX(Pawn); isQueen(Pawn)), 
    To is From + 11, !. 

%%
%% 10 - 1 Diagonal bas gauche
%%
isValideBL(_, From, To, Pawn) :- 
    (isX(Pawn); isQueen(Pawn)), To is From + 9, !.  
    
%%
%% Diagonal haut gauche
%%
isValideTL(_, From, To, Pawn) :- 
    (isO(Pawn); isQueen(Pawn)), To is From - 11, !.
    
%%
%% Diagonal haut droite
%%
isValideTR(_, From, To, Pawn) :- 
    (isO(Pawn); isQueen(Pawn)), To is From - 9, !.
	
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
	
%% ------------------------------------- %%
%% Check if a move exist from a position %%
%% ------------------------------------- %%

moveLeft(Board, Pawn) :-
    nth(To, Board, '   '),
    (existValide(Board, _, To, Pawn); existValideEat(Board, _, _, To, Pawn)), !.

existValide(Board, From, To, ' x ') :-
	(From is To - 11; 
	From is To - 9),
	nth1(From, Board, ' x '). 
	
existValide(Board, From, To, ' o ') :-
	(From is To + 11; 
	From is To + 9),
	nth1(From, Board, ' o '). 

existValideEat(Board, From, Between, To, Pawn) :-
	(Between is To + 11; 
	Between is To + 9; 
	Between is To - 11;
	Between is To - 9),
	invert_player(Pawn, Enemi),
	nth1(Between, Board, Enemi),
	existValide(Board, From, Between, Pawn).
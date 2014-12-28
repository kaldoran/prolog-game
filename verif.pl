%% Author : Reynaud Nicolas

isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	(member(Looser, Board), !, fail; true).
	
	
%% -------------------------------- %%
%% Verification Dame - A TRAVAILLER %%
%% -------------------------------- %%
     
isValide(Board, From, To, Pawn) :-
	From \== To,
	nth1(From, Board, Pawn),
	nth1(To, Board, '   '),
	isValideSpecial(Board, From, To, Pawn).

%% Validation Pion
%% --------------- %%

isValideSpecial(_, From, To, ' x ') :-
    To is From + 11;                                    %% Diagonal bas droite ( 10 + 1)
    To is From + 9.                                     %% Diagonal bas gauche ( 10 - 1)
	
isValideSpecial(_, From, To, ' o ') :-
	To is From - 9;                                     %% Diagonal haut droite 
	To is From - 11.                                    %% Diagonal haut gauche

%% Validation Reine
%% ---------------- %%
isValideSpecial(_, From, To, Pawn) :-
    isQueen(Pawn),
    Distance is abs(From - To),
    ( mod(Distance, 11) =:= 0, 
      ( From > To -> 
            isValideDiagTL(Board, From, To, Pawn); 
            isValideDiagBR(Board, From, To, Pawn)
      );                                                %% OR
      mod(Distance, 9) =:= 0,
      ( From > To -> 
            isValideDiagTR(Board, From, To, Pawn); 
            isValideDiagBL(Board, From, To, Pawn)
      );                                                %% OR
      fail), !.

isValideDiagBR(_, To, To, _).
isValideDiagBR(Board, From, To, Pawn) :-
    FromBis is From + 11,    
    nth1(FromBis, Board, '   '),
    isValideDiagBR(_, FromBis, To, Pawn), !.
   
isValideDiagBL(_, To, To, _).
isValideDiagBL(Board, From, To, Pawn) :-
    FromBis is From + 9,
    nth1(FromBis, Board, '   '),
    isValideDiagBL(_, FromBis, To, Pawn), !.
    
isValideDiagTR(_, To, To, _).
isValideDiagTR(Board, From, To, Pawn) :-
    FromBis is From - 9,
    nth1(FromBis, Board, '   '),
    isValideDiagTR(_, FromBis, To, Pawn), !.
    
isValideDiagTL(_, To, To, _).
isValideDiagTL(Board, From, To, Pawn) :-
    FromBis is From - 11,
    nth1(FromBis, Board, '   '),
    isValideDiagTL(_, FromBis, To, Pawn), !.
%% -------------------------------- %%
    
%% ------------------------------- %%
%% Verification du l action joueur %%
%% ------------------------------- %%

	
isValideEat(Board, From, Between, To, Pawn) :-
	(Between is From + 11; 
	Between is From + 9; 
	Between is From - 11;
	Between is From - 9),
	nth1(Between, Board, Enemi),
	(
	    queen(EnemiPawn, Enemi); 
	    EnemiPawn = Enemi
	),
	invert_player(Pawn, EnemiPawn),
	isValide(Board, Between, To, EnemiPawn).

%% ------------------------------------- %%
%% Check if the movement is on the board %%
%% ------------------------------------- %%
check([Row, Column], Square, Board, PlayPawn) :-
	checkColumn(Column),
	checkRow(Row),
	nth1(Square, Board, Pawn),
	(PlayPawn = Pawn; queen(PlayPawn, QueenPawn), Pawn = QueenPawn).

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

existValide(Board, From, To, Pawn) :-
    isX(Pawn),
	(From is To - 11; 
	From is To - 9),
	nth1(From, Board, Pawn). 
	
existValide(Board, From, To, Pawn) :-
    isO(Pawn),
	(From is To + 11; 
	From is To + 9),
	nth1(From, Board, Pawn). 

existValideEat(Board, From, Between, To, Pawn) :-
	(Between is To + 11; 
	Between is To + 9; 
	Between is To - 11;
	Between is To - 9),
	invert_player(Pawn, Enemi),
	nth1(Between, Board, Enemi),
	existValide(Board, From, Between, Pawn).
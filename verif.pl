%% Author : Reynaud Nicolas (Kaldoran)

% Check on the '+Board' if there is a Winner
% If there is one '-Winner' is set
% ------------------------------------------ %
isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
	(member(Looser, Board), !, fail; true).
	
	
%% ----------------- %%
%% Verification Dame %%
%% ----------------- %%
     
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
isValideSpecial(Board, From, To, Pawn) :-
    isQueen(Pawn),
    Distance is abs(From - To),
    ( mod(Distance, 11) =:= 0, 
      ( isValideDiagTL(Board, From, To, Pawn); 
        isValideDiagBR(Board, From, To, Pawn)
      );                                                %% OR
      mod(Distance, 9) =:= 0,
      ( isValideDiagTR(Board, From, To, Pawn); 
        isValideDiagBL(Board, From, To, Pawn)
      );                                                %% OR
      fail), !.

isValideDiagBR(_, To, To, _).
isValideDiagBR(Board, From, To, Pawn) :-
    From < To,
    FromBis is From + 11,    
    nth1(FromBis, Board, '   '),
    isValideDiagBR(Board, FromBis, To, Pawn), !.
   
isValideDiagBL(_, To, To, _).
isValideDiagBL(Board, From, To, Pawn) :-
    From < To,
    FromBis is From + 9,
    nth1(FromBis, Board, '   '),
    isValideDiagBL(Board, FromBis, To, Pawn), !.
    
isValideDiagTR(_, To, To, _).
isValideDiagTR(Board, From, To, Pawn) :-
    From > To,
    FromBis is From - 9,
    nth1(FromBis, Board, '   '),
    isValideDiagTR(Board, FromBis, To, Pawn), !.
    
isValideDiagTL(_, To, To, _).
isValideDiagTL(Board, From, To, Pawn) :-
    From > To,
    FromBis is From - 11,
    nth1(FromBis, Board, '   '),
    isValideDiagTL(Board, FromBis, To, Pawn), !.
%% -------------------------------- %%
    
%% ------------------------------- %%
%% Verification du l action joueur %%
%% ------------------------------- %%


%% Validation saut pion 
%% -------------------- %%
isValideEat(Board, From, Between, To, Pawn) :-
    isRegularPawn(Pawn),
    ( 
        Between is From + 11, To is Between + 11;
        Between is From + 9,  To is Between + 9;
        Between is From - 9,  To is Between - 9;
        Between is From - 11, To is Between - 11
    ),
    invert_player(Pawn, EnemiPawn),
    nth1(Between, Board, Enemi),
    (
	    queen(EnemiPawn, Enemi); 
	    EnemiPawn = Enemi
	).


%% Validation saut Reine
%% --------------------- %%
isValideEat(Board, From, Between, To, Queen) :-
    isQueen(Queen),
    seekPawnBetween(Board, From, Between, To, Queen),
    removePawn(Board, Between, NewBoard),
    isValideSpecial(NewBoard, From, To, Queen).
    
seekPawnBetween(Board, From, Between, To, Queen) :-
    isQueen(Queen),
    Distance is abs(From - To),
    ( mod(Distance, 11) =:= 0, 
      ( seekPawnBetweenTL(Board, From, Between, To, Queen); 
        seekPawnBetweenBR(Board, From, Between, To, Queen)
      );                                                %% OR
      mod(Distance, 9) =:= 0,
      ( seekPawnBetweenTR(Board, From, Between, To, Queen); 
        seekPawnBetweenBL(Board, From, Between, To, Queen)
      );                                                %% OR
      fail), !.

checkPawnBetween(Board, _, Between, _, Queen) :-
    number(Between),
    queen(Pawn, Queen),
    invert_player(Pawn, EnemiPawn),
    nth1(Between, Board, Enemi),
    (      
        queen(EnemiPawn, Enemi);
        Enemi = EnemiPawn
    ), !.
    
        
seekPawnBetweenBR(Board, From, Between, To, Queen) :-
    From < To,
    FromBis is From + 11,    
    nth1(FromBis, Board, '   '),
    seekPawnBetweenBR(Board, FromBis, Between, To, Queen) , !.

seekPawnBetweenBR(Board, From, Between, To, Queen) :-
    From < To,
    Between is From + 11,
    checkPawnBetween(Board, From, Between, To, Queen).
       
seekPawnBetweenBL(Board, From, Between, To, Queen):-
    From < To,
    FromBis is From + 9,
    nth1(FromBis, Board, '   '),
    seekPawnBetweenBL(Board, FromBis, Between, To, Queen) , !.
    
seekPawnBetweenBL(Board, From, Between, To, Queen) :-
    From < To,
    Between is From + 9,
    checkPawnBetween(Board, From, Between, To, Queen).
       
seekPawnBetweenTR(Board, From, Between, To, Queen) :-
    From > To,
    FromBis is From - 9,
    nth1(FromBis, Board, '   '),
    seekPawnBetweenTR(Board, FromBis, Between, To, Queen) , !.
    
seekPawnBetweenTR(Board, From, Between, To, Queen) :-
    From > To,
    Between is From - 9,
    checkPawnBetween(Board, From, Between, To, Queen).
    
seekPawnBetweenTL(Board, From, Between, To, Queen) :-
    From > To,
    FromBis is From - 11,
    nth1(FromBis, Board, '   '),
    seekPawnBetweenTL(Board, FromBis, Between, To, Queen) , !.
    
seekPawnBetweenTL(Board, From, Between, To, Queen) :-
    From > To,
    Between is From - 11,
    checkPawnBetween(Board, From, Between, To, Queen).
    
%% -------------------------------- %%
	
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

                                                                        %% ========= %%
                                                                        %% A CHANGER %%
                                                                        %% ========= %%
moveLeft(Board, Pawn) :-
    nth(To, Board, '   '),
    (existValide(Board, _, To, Pawn); existValideEat(Board, _, _, To, Pawn)), !.
                                                                        %% ========= %%                                                 
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
	(
	    Between is To + 11, From is Between + 11; 
	    Between is To + 9, From is Between + 9; 
	    Between is To - 11, From is Between - 11;
	    Between is To - 9, From is Between - 9
	),
    invert_player(Pawn, EnemiPawn),
    nth1(Between, Board, Enemi),
    (
	    queen(EnemiPawn, Enemi); 
	    EnemiPawn = Enemi
	),
	nth1(From, Board, Pawn).
	
existValideEatFrom(Board, From, Between, To, Pawn) :-
	(
	    Between is From + 11, To is Between + 11; 
	    Between is From + 9, To is Between + 9; 
	    Between is From - 11, To is Between - 11;
	    Between is From - 9, To is Between - 9
	),
    invert_player(Pawn, EnemiPawn),
    nth1(Between, Board, Enemi),
    (
	    queen(EnemiPawn, Enemi); 
	    EnemiPawn = Enemi
	),
	nth1(To, Board, '   ').
	
existNextEat(Board, From, Pawn) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    existNextValideEat(Board, From, Pawn, BlankSpace).

existNextValideEat(_, _, _, []) :- fail, !.

existNextValideEat(Board, From, Pawn, [To|BlankSpace]) :-
    Distance is abs(From - To),
    ( mod(Distance, 11) =:= 0; mod(Distance, 9) =:= 0), 
    isValideEat(Board, From, _, To, Pawn), !;
    existNextValideEat(Board, From, Pawn, BlankSpace).
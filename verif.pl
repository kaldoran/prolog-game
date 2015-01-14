%% Author : Reynaud Nicolas (Kaldoran)

% Check on the '+Board' if there is a Winner
% If there is one '-Winner' is set
% ------------------------------------------ %
isEndGame(Board, Winner) :-
	isPawn(Looser),
	invert_player(Looser, Winner),
    \+ member(Looser, Board),
    queen(Looser, QueenLooser),
    \+ member(QueenLooser, Board), !.
	
	
%% ------------------------ %%
%% Check Validity os a move %%
%% ------------------------ %%

% Check if the '+Pawn' could go from '+From' To '+To' on the '+Board'
% ------------------------------------------------------------------- %
     
isValide(Board, From, To, Pawn) :-
	From \== To,
	nth1(From, Board, Pawn),
	nth1(To, Board, '   '),
	isValideSpecial(Board, From, To, Pawn).

%% Check if the Pawn go in the right direction
%% ------------------------------------------- %%

isValideSpecial(_, From, To, ' x ') :-
    To is From + 11;                                    %% Diagonal bas droite ( 10 + 1)
    To is From + 9.                                     %% Diagonal bas gauche ( 10 - 1)
	
isValideSpecial(_, From, To, ' o ') :-
	To is From - 9;                                     %% Diagonal haut droite 
	To is From - 11.                                    %% Diagonal haut gauche

%% Validation of Queen Move
%% ------------------------ %%

%% Check if the '+Pawn' could go '+From' to '+To' on the '+Board'
%% ------------------------------------------------------------- %%
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

%% Check the Bottom Right diagonal for Queen
%% ----------------------------------------- %%
isValideDiagBR(_, To, To, _).
isValideDiagBR(Board, From, To, Pawn) :-
    From < To,
    FromBis is From + 11,    
    nth1(FromBis, Board, '   '),
    isValideDiagBR(Board, FromBis, To, Pawn), !.


%% Check the Bottom Left diagonal for Queen
%% ----------------------------------------- %%
isValideDiagBL(_, To, To, _).
isValideDiagBL(Board, From, To, Pawn) :-
    From < To,
    FromBis is From + 9,
    nth1(FromBis, Board, '   '),
    isValideDiagBL(Board, FromBis, To, Pawn), !.


%% Check the Top Right diagonal for Queen
%% -------------------------------------- %%
isValideDiagTR(_, To, To, _).
isValideDiagTR(Board, From, To, Pawn) :-
    From > To,
    FromBis is From - 9,
    nth1(FromBis, Board, '   '),
    isValideDiagTR(Board, FromBis, To, Pawn), !.


%% Check the Top Left diagonal for Queen
%% ----------------------------------------- %%   
isValideDiagTL(_, To, To, _).
isValideDiagTL(Board, From, To, Pawn) :-
    From > To,
    FromBis is From - 11,
    nth1(FromBis, Board, '   '),
    isValideDiagTL(Board, FromBis, To, Pawn), !.
%% -------------------------------- %%
    

%% Check if the Eat From '+From' To '+To' with the '+Pawn' on the '+Board'
%% Is correct and ouput the '-Between' position of pawn to eat
%% ---------------------------------------------------------------------- %%
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


%% Check the Eat of a '+Queen' From '+From' to '+To'
%% On the '+Board' and output '-Between'
%% ------------------------------------------------ %%
isValideEat(Board, From, Between, To, Queen) :-
    isQueen(Queen),
    seekPawnBetween(Board, From, Between, To, Queen),
    removePawn(Board, Between, NewBoard),
    isValideSpecial(NewBoard, From, To, Queen).

%% Look the the enemi pawn to '+Queen' between '+From' and '+To'
%% On the '+Board'
%% ------------------------------------------------------------- %%
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

%% Check if the pawn on the '+Between' square 
%% is enemi of '+Queen' on '+Board'
%% ------------------------------------------ %%
checkPawnBetween(Board, _, Between, _, Queen) :-
    number(Between),
    queen(Pawn, Queen),
    invert_player(Pawn, EnemiPawn),
    nth1(Between, Board, Enemi),
    (      
        queen(EnemiPawn, Enemi);
        Enemi = EnemiPawn
    ), !.
    

%% Seek the Enemy Pawn on the Bottom Right Diagonal
%% ------------------------------------------------ %%
seekPawnBetweenBR(Board, From, Between, To, Queen) :-
    From < To,
    FromBis is From + 11,    
    nth1(FromBis, Board, '   '),
    seekPawnBetweenBR(Board, FromBis, Between, To, Queen) , !.

%% As 'nth1(FromBis, Board, '   ')' is the only predicat that could fail,
%% This one is alternativs, this one is execute if we not found empty space
%% Seek the Enemy Pawn on the Bottom Right Diagonal
%% --------------------------------------------------------------------- %%
seekPawnBetweenBR(Board, From, Between, To, Queen) :-
    From < To,
    Between is From + 11,
    checkPawnBetween(Board, From, Between, To, Queen).

%% Seek the Enemy Pawn on the Bottom Left Diagonal
%% ----------------------------------------------- %%
seekPawnBetweenBL(Board, From, Between, To, Queen):-
    From < To,
    FromBis is From + 9,
    nth1(FromBis, Board, '   '),
    seekPawnBetweenBL(Board, FromBis, Between, To, Queen) , !.
    
%% Seek the Enemy Pawn on the Bottom Left Diagonal
%% ----------------------------------------------- %%
seekPawnBetweenBL(Board, From, Between, To, Queen) :-
    From < To,
    Between is From + 9,
    checkPawnBetween(Board, From, Between, To, Queen).
    
%% Seek the Enemy Pawn on the Top Right Diagonal
%% --------------------------------------------- %%
seekPawnBetweenTR(Board, From, Between, To, Queen) :-
    From > To,
    FromBis is From - 9,
    nth1(FromBis, Board, '   '),
    seekPawnBetweenTR(Board, FromBis, Between, To, Queen) , !.

%% Seek the Enemy Pawn on the Top Right Diagonal
%% --------------------------------------------- %%
seekPawnBetweenTR(Board, From, Between, To, Queen) :-
    From > To,
    Between is From - 9,
    checkPawnBetween(Board, From, Between, To, Queen).
    
%% Seek the Enemy Pawn on the Top Left Diagonal
%% -------------------------------------------- %%
seekPawnBetweenTL(Board, From, Between, To, Queen) :-
    From > To,
    FromBis is From - 11,
    nth1(FromBis, Board, '   '),
    seekPawnBetweenTL(Board, FromBis, Between, To, Queen) , !.
    
%% Seek the Enemy Pawn on the Top Left Diagonal
%% -------------------------------------------- %%
seekPawnBetweenTL(Board, From, Between, To, Queen) :-
    From > To,
    Between is From - 11,
    checkPawnBetween(Board, From, Between, To, Queen).
    
%% -------------------------------- %%
	

%% Check if the '+Row, Column' movement is on the '+Board'
%% And is a '+PlayPawn' then output the '-Square'
%% ----------------------------------------------------- %%
check([Row, Column], Square, Board, PlayPawn) :-
	checkColumn(Column),
	checkRow(Row),
	nth1(Square, Board, Pawn),
	(PlayPawn = Pawn; queen(PlayPawn, QueenPawn), Pawn = QueenPawn).

%% Check the column
%% ---------------- %%
checkColumn(Column) :-
	Column > 0,
	Column =< 10.

%% Unexpect : 
%% Check the Row
%% if it's between 'a' and 'k'
%% ---------------------- %%
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
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    checkMoveLeft(Board, BlankSpace, Pawn).

checkMoveLeft(Board, [To|BlankSpace], Pawn) :-
     existValide(Board, _, To, Pawn), !;
     existValideEat(Board, _, _, To, Pawn), !;
     checkMoveLeft(Board, BlankSpace, Pawn).                                              
%% Try to find a '-From' Position available according to the '+To'
%% And the '+Pawn' on the '+Board'
%% --------------------------------------------------------------- %%

%% For X
existValide(Board, From, To, Pawn) :-
    isX(Pawn),
	(From is To - 11; 
	From is To - 9),
	nth1(From, Board, Pawn). 

%% For Y
existValide(Board, From, To, Pawn) :-
    isO(Pawn),
	(From is To + 11; 
	From is To + 9),
	nth1(From, Board, Pawn). 

%% Look for a valide Eat with pawn on the square '-Between'
%% as an enemy of '+Pawn' and give '-From'
%% On the '+Board'
%% -------------------------------------------------------- %%
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

%% Given a '+From' try to found the '-Between' and '-To' 
%% according to the '+Pawn' on the '+Board'
%% ----------------------------------------------------- %%
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

%% Check if existe a next valide eat for the '+Pawn' According to the last 
%% jump position '+From' on the '+Board'
%% ----------------------------------------------------------------------- %%
existNextEat(Board, From, Pawn) :-
    findall(Place, nth1(Place, Board, '   '), BlankSpace),
    existNextValideEat(Board, From, Pawn, BlankSpace).

existNextValideEat(_, _, _, []) :- fail, !.

%% Seek a valide eat according on the '+Blankspace' Array
%% That try to found '+From' to '+To' valide jump
%% ------------------------------------------------------ %%
existNextValideEat(Board, From, Pawn, [To|BlankSpace]) :-
    Distance is abs(From - To),
    ( mod(Distance, 11) =:= 0; mod(Distance, 9) =:= 0), 
    isValideEat(Board, From, _, To, Pawn), !;
    existNextValideEat(Board, From, Pawn, BlankSpace).
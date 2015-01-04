%% Author : Reynaud Nicolas

% Ask a move on the '+Board', with the '+PlayPawn'
% Output the '-From', '-To', to move pawn From to To
% -------------------------------------------------- %
askMove(From, To, Board, PlayPawn) :-
	write('From - To [Row, Column] - [Row, Column] ? '),
	read(RowColumnFrom - RowColumnTo), 
	convert(RowColumnFrom, From), 
	convert(RowColumnTo, To), 
	writeDebug(' Square N° [+1 Cause nth need +1]: '), writeDebug(From), write(' - '), writeDebug(To), nl, 
	check(RowColumnFrom, From, Board, PlayPawn),
	check(RowColumnTo, To, Board, '   '). 

% Alternative predicate 
% If move is not valide write non valide and ask for another
% ---------------------------------------------------------- %
askMove(From, To, Board, PlayPawn) :-
    write('[WARNING] : Illegal Move. Play Again !'), nl,
	askMove(From, To, Board, PlayPawn).

% Ask player if he got an other move
% ---------------------------------- %
askEndMove :-
    write('Do you have any extra move ? [y]es or [N]o or [e]xit.'), nl,
    read(Answer),
    ( Answer = 'y', true; Answer = 'e', halt; fail).
    

% Do a multi move
% --------------- %
multiMove(Board, [], _, Board).

% Apply '+MultiMove' on the '+Board' with the '+Pawn'
% Output the '-NewBoard'
% --------------------------------------------------- %
multiMove(Board, [From, To|MultiMove], Pawn, NewBoard) :-
    move(Board, From, To, Pawn, TmpBoard),
    multiMove(TmpBoard, MultiMove, Pawn, NewBoard).

% Alternative for a MultiMove with a jump
% Same input / Output as previous 
% --------------------------------------- %
multiMove(Board, [[From, Between, To]|MultiMove], Pawn, NewBoard) :-
    move(Board, From, To, Pawn, TmpBoard),
    removePawn(TmpBoard, Between, TmpBoardBis),
    multiMove(TmpBoardBis, MultiMove, Pawn, NewBoard).

% Apply the Move but first, change the pawn to a Queen if needed 
% -------------------------------------------------------------- %
move(Board, From, To, Pawn, NewBoard) :-
	( To >= 90; To =< 10),
	queen(Pawn, Queen),
	doMove(Board, From, To, Queen, NewBoard).
	
% Apply the move if there is no change to Pawn
% -------------------------------------------- %
move(Board, From, To, Pawn, NewBoard) :-
    doMove(Board, From, To, Pawn, NewBoard).
    
% Copy the board
% -------------- %
doMove([], _, _, _, []).

% Copy the '+Board' remplacing the '+From' Pawn, By '   '
% And the To Pawn by '+Pawn'
% OutputAll to '-NewBoard'
% ------------------------------------------------------- %

doMove([_|Board], 1, To, Pawn, ['   '|NewBoard]) :-
	NewTo is To - 1,
	doMove(Board, 0, NewTo, Pawn, NewBoard), !.
doMove([_|Board], From, 1, Pawn, [Pawn|NewBoard]) :-
	NewFrom is From - 1,
	doMove(Board, NewFrom, 0, Pawn, NewBoard), !.
doMove([X|Board], From, To, Pawn, [X|NewBoard]) :-
	NewFrom is From - 1,
	NewTo is To - 1,
	doMove(Board, NewFrom, NewTo, Pawn, NewBoard).
	
% Remove the pawn on the '+Board' at '+Square'
% Output the '-NewBoard'
% -------------------------------------------- %
removePawn(Board, Square, NewBoard) :-
	move(Board, Square, 0, '   ',NewBoard).
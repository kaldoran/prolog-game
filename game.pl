%% Author : Reynaud Nicolas

:- include('base.pl').
:- include('affichage.pl').
:- include('interaction.pl').
:- include('verif.pl').

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
    invert_player(Pawn, EnemiPawn), 
	( moveLeft(Board, Pawn) -> 
	    write('Time to play : '), write(Pawn), nl;
	    write(Pawn), write(' ne peux pas jouer.'), nl, play(Board, EnemiPawn), nl
	),
	askMoveFrom(From, Board, Pawn),
	askMoveTo(To, Board, Pawn),
	nth1(From, Board, Value),
	(isValide(Board, From, To, Value), move(Board, From, To, Value, NewBoard);
	isValideEat(Board, From, Between, To, Pawn), removePawn(Board, Between, TmpBoard), move(TmpBoard, From, To, Value, NewBoard)),
	play(NewBoard, EnemiPawn).
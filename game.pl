%% Author : Reynaud Nicolas

:- include('base.pl').
:- include('affichage.pl').
:- include('interaction.pl').
:- include('verif.pl').

:- retract(iPlay(' x ')).
:- retract(iPlay(' o ')).

play :- 
    initialize_game(Board),
    asserta(iPlay(' x ')), asserta(iPlay(' o ')),
    play(Board, ' x ').
    
playX :-
	initialize_game(Board),
	asserta(iPlay(' x ')),
	play(Board, ' x ').                 % les X commencent toujours

playO :-
	initialize_game(Board), 
	asserta(iPlay(' o ')), 
	play(Board, ' x ').

play(Board, _) :-
	isEndGame(Board, Winner),
	write('The Winner Is : '),
	write(Winner), !.
	
play(Board, Pawn) :-
	printBoard(Board),
    invert_player(Pawn, EnemiPawn), 
	( moveLeft(Board, Pawn) -> 
	    write('Time to play : '), write(Pawn), nl;
	    write(Pawn), write(' ne peux pas jouer.'), nl, play(Board, EnemiPawn), nl
	),
	( 
	    iPlay(Pawn),
	    askMoveFrom(From, Board, Pawn),
	    askMoveTo(To, Board, Pawn),
	    nth1(From, Board, Pawn),
	    (
	        isValide(Board, From, To, Pawn), 
	        move(Board, From, To, Pawn, NewBoard);
	    
	        isValideEat(Board, From, Between, To, Pawn),
	        removePawn(Board, Between, TmpBoard),
	        move(TmpBoard, From, To, Pawn, NewBoard)
	    ),
	    ( 
	        askEndMove, 
	        play(NewBoard, Pawn), !;
	        
	        play(NewBoard, EnemiPawn)
	    ) 
	  ;
	  
	  playIA(Board, From, To, Pawn), 
	  move(Board, From, To, Pawn, NewBoard),
	  play(NewBoard, EnemiPawn)
	).
	  
	  
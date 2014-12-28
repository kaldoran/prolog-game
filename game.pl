%% Author : Reynaud Nicolas

:- include('base.pl').
:- include('affichage.pl').
:- include('interaction.pl').
:- include('verif.pl').

clear :- clearX, clearO.
clearX :- iPlay(' x '), retract(iPlay(' x ')); true.
clearO :- iPlay(' o '), retract(iPlay(' o ')); true.

play :- 
    initialize_game(Board),
    clear,
    asserta(iPlay(' x ')), asserta(iPlay(' o ')),
    play(Board, ' x ').
    
playX :-
	initialize_game(Board),
	clear,
	asserta(iPlay(' x ')),
	play(Board, ' x ').                 % les X commencent toujours

playO :-
	initialize_game(Board), 
	clear,
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
	    askMove(From, To, Board, Pawn),
	    nth1(From, Board, Pawn),
	    (
	        isValide(Board, From, To, Pawn), 
	        move(Board, From, To, Pawn, NewBoard);
	    
	        isValideEat(Board, From, Between, To, Pawn),
	        removePawn(Board, Between, TmpBoard),
	        move(TmpBoard, From, To, Pawn, NewBoard)
	    ),
	    ( 
	        printBoard(NewBoard),
	        askEndMove, 
	        (existNextEat(Board, To, Pawn) ->  
	            play(NewBoard, Pawn), !;
	            
	            write(' Tu m\'a pris pour un jambon ? tu as plus de coup possible'), nl, play(NewBoard, EnemiPawn), nl
	        )
	    ) 
	  ;
	  
	  playIA(Board, From, To, Pawn), 
	  move(Board, From, To, Pawn, NewBoard),
	  play(NewBoard, EnemiPawn)
	).
	  
	  
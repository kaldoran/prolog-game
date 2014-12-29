%% Author : Reynaud Nicolas

:- include('base.pl').
:- include('affichage.pl').
:- include('interaction.pl').
:- include('verif.pl').

clear :- clearX, clearO.
clearX :- retract(iPlay(' x ')); true.
clearO :- retract(iPlay(' o ')); true.

play :- 
    initialize_game(Board),
    clear,
    asserta(iPlay(' x ')), asserta(iPlay(' o ')),
    play(Board, ' o ').
    
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
	    nth(From, Board, PawnMove),
	    (
	        isValide(Board, From, To, PawnMove), 
	        move(Board, From, To, PawnMove, NewBoard);
	    
	        isValideEat(Board, From, Between, To, PawnMove),
	        removePawn(Board, Between, TmpBoard),
	        move(TmpBoard, From, To, PawnMove, NewBoard),
            printBoard(NewBoard),
            (askEndMove; play(NewBoard, EnemiPawn)),
            (existNextEat(NewBoard, To, PawnMove) ->  
                play(NewBoard, Pawn), !;
                
                write(' Tu m\'a pris pour un jambon ? tu as plus de coup possible'), nl
            )
        )
	    ;
	  
        playIA(Board, From, To, Pawn), 
        nth(From, Board, PawnMove),
        move(Board, From, To, PawnMove, NewBoard),
        play(NewBoard, EnemiPawn)
    ),
    play(NewBoard, EnemiPawn).
	  
	  
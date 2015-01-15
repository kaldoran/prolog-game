%% Author : Reynaud Nicolas (Kaldoran)

:- include('base.pl').
:- include('affichage.pl').
:- include('interaction.pl').
:- include('verif.pl').
:- include('ia.pl').
:- include('ia_offensif.pl').

% Clear the assert prédicate
% -------------------------- %
clear :- clearX, clearO.
clearX :- retract(iPlay(' x ')); true.
clearO :- retract(iPlay(' o ')); true.

%% ------------ Note : X always start the game

% Launch this predicate to play 2 V 2
% ----------------------------------- %
play :- 
    initialize_game(Board),
    clear,
    asserta(iPlay(' x ')), asserta(iPlay(' o ')),
    play(Board, ' x ', 0).

% Launch this predicate to play Vs AI, AI plays ' o ', you play ' x '
% ----------------------------------------------------------------- %
playX :-
	initialize_game(Board),
	clear,
	asserta(iPlay(' x ')),
	askAI(AI),
	play(Board, ' x ', AI).

% Launch this predicate to play Vs AI, AI plays ' x ', you play ' o '
% ----------------------------------------------------------------- %
playO :-
	initialize_game(Board), 
	clear,
	asserta(iPlay(' o ')), 
	askAI(AI),
	play(Board, ' x ', AI).

% Launch this predicate to watch a match AI vs AI
% ----------------------------------------------- %
playAIs:-
	initialize_game(Board), 
	clear,
    write('For the black pawns. '), askAI(AIB), nl,
    write('For the white pawns. '), askAI(AIW), nl,
	printBoard(Board), 
    findPlay(Board, ' x ', 1, Moves, AIB),
    write('Black AI had done her move.'), nl, 
    write('Move : '), write(Moves),
    multiMove(Board, Moves, NewBoard),
    play(NewBoard, ' o ', AIB), !;
        
    write('Black AI cannot play'), nl, 
    play(Board, ' o ', AIB), !;
    
    findPlay(Board, ' o ', 1, Moves, AIW),
    write('White AI had done her move.'), nl, 
    write('Move : '), write(Moves),
    multiMove(Board, Moves, NewBoard),
    play(NewBoard, ' x ', AIW), !;
        
    write('White AI cannot play'), nl, 
    play(Board, ' x ', AIW), !.
    
    
% Check if there is a winner on the '+Board', if there is, write the winner
% ------------------------------------------------------------------------- %
play(Board, _, _) :-
	isEndGame(Board, Winner),
	write('The Winner Is : '),
	write(Winner), nl, halt.
	
% Alternative predicate if there is no winner then play on the '+Board' with '+Pawn'
% --------------------------------------------------------------------------------- %
play(Board, Pawn, AI) :-
    invert_player(Pawn, EnemyPawn), 
	( 
	    (
	        moveLeft(Board, Pawn);
	        queen(Pawn, Queen), moveLeft(Board, Queen)
	    ) -> 
	        write('Time to play : '), write(Pawn), nl;
	        write(Pawn), write(' cannot play.'), nl, play(Board, EnemyPawn, AI), !, nl
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
            (
                askEndMove; 
                
                play(NewBoard, EnemyPawn, AI)
            ),
            (existNextEat(NewBoard, To, PawnMove) ->  
                play(NewBoard, Pawn, AI), !;
                
                write(' Tu m\'a pris pour un jambon ? tu as plus de coup possible'), nl
            )
        )
	    ; 
        findPlay(Board, Pawn, 1, Moves, AI),

        write('AI had done her move.'), nl, 
        write('Move : '), write(Moves),
        multiMove(Board, Moves, NewBoard),
        play(NewBoard, EnemyPawn, AI), !;
        
        write('AI cannot play'), nl, 
        play(Board, EnemyPawn, AI), !
    ),
    play(NewBoard, EnemyPawn, AI), !.
	  
	  

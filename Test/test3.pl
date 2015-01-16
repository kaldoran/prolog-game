%% Author : Reynaud Nicolas (Kaldoran)

% Ce prédicat montre juste que l'ia prend toujours les pions, quitte a se faire hypothétiquement
% manger par le joueur humain apres.

% Lancez test3. pour voir le résultat.

initialize_game_test3([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	       ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ','   ',' w ','   ',' w ',' x ',' w ',' x ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ','   ',' w ','   ',
				       '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				      ] ).

test3 :-
    asserta(iPlay(' o ')), 
    initialize_game_test3(Board), 
    printBoard(Board),
    findPlay(Board, ' x ', 1, Moves, 1), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), 
    retract(iPlay(' o ')), !.
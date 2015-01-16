%% Author : Bascol Kevin (Vanelric)

% Ce test montre qu'au départ, sans pion adverse à prendre, l'ordinateur vas chercher à augmenter la valeur totale de ses cases.

% Lancez test4. pour voir le résultat.

initialize_game_test4([ ' w ',' X ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	       ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ','   ',' w ',' x ',' w ',' x ',' w ',
				       ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				       '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				      ] ).

test4 :-
    asserta(iPlay(' x ')),
    initialize_game_test4(Board), 
    printBoard(Board),
    findPlay(Board, ' o ', 3, Moves, 2), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), 
    retract(iPlay(' x ')), !.

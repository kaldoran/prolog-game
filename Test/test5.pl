% Ce test montre que lors que l'ordinateur a le choix entre 2 pions pour manger un même pion adverse il va choisir la destination de plus haute valeur.

% Lancez test5. pour voir le résultat.

initialize_game_test5([ ' w ',' X ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	       ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ','   ',' w ',' x ',' w ',' x ',' w ',
				       ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				       '   ',' w ','   ',' w ',' x ',' w ','   ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				      ] ).

test5 :-
    initialize_game_test5(Board), 
    printBoard(Board),
    findPlay(Board, ' o ', 3, Moves, 2), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), !.

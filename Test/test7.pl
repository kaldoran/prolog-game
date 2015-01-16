% Ce test montre que lors que l'ordinateur a le choix entre 2 pions pour manger un même pion adverse il va choisir la destination de plus haute valeur.

% Lancez test5. pour voir le résultat.

initialize_game_test5([ ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',' x ',
				       ' x ',' w ',' x ',' w ',' x ',' w ',' o ',' w ','   ',' w ',
			 	       ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' o ',
				       ' x ',' w ',' x ',' w ','   ',' w ',' x ',' w ',' o ',' w ',
				       ' w ',' x ',' w ',' x ',' w ',' o ',' w ','   ',' w ',' o ',
				       ' x ',' w ','   ',' w ',' x ',' w ','   ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ','   ',' w ',' o ',
				       ' x ',' w ','   ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' x ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' X ',' w ',' o ',' w ','   ',' w ',' X ',' w ',' X ',' w '
				      ] ).

test5 :-
    asserta(iPlay(' x ')),
    initialize_game_test5(Board), 
    printBoard(Board),
    findPlay(Board, ' o ', 2, Moves, 3), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), 
    retract(iPlay(' x ')), !.
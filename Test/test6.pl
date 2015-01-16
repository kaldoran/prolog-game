% Ce test montre que lors que l'ordinateur a plus de choix de pions à prendre alors il prendra le coup le menant à la case de plus haute valeur.

% Lancez test6. pour voir le résultat.

initialize_game_test6([ ' w ',' X ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	       ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ','   ',' w ',' x ',' w ',' x ',' w ',
				       ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				       '   ',' w ','   ',' w ',' x ',' w ','   ',' w ',' x ',' w ',
				       ' w ',' x ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				      ] ).

test6 :-
    initialize_game_test6(Board), 
    printBoard(Board),
    findPlay(Board, ' o ', 3, Moves, 2), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), !.

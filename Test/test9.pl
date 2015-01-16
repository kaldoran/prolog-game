%% Author : Laoussing Kevin (KevL974)

% Ce test montre que lors que l'ordinateur a le choix entre 2 pions pour manger un même pion adverse il va choisir la destination de plus haute valeur.

% Lancez test5. pour voir le résultat.

initialize_game_test9([ ' w ','   ',' w ','   ',' w ',' x ',' w ','   ',' w ',' O ',
				       ' o ',' w ',' x ',' w ','   ',' w ','   ',' w ','   ',' w ',
			 	       ' w ',' o ',' w ',' x ',' w ','   ',' w ',' x ',' w ','   ',
				       ' o ',' w ',' x ',' w ',' x ',' w ',' x ',' w ','   ',' w ',
				       ' w ',' X ',' w ',' x ',' w ',' o ',' w ',' x ',' w ','   ',
				       '   ',' w ',' x ',' w ',' x ',' w ',' x ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ','   ',' w ','   ',
				       ' o ',' w ','   ',' w ','   ',' w ','  ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ','   ',' w ',' o ',' w ','   ',
				       '   ',' w ','   ',' w ','   ',' w ','   ',' w ',' X ',' w '
				      ] ).

test5 :-
    asserta(iPlay(' x ')),
    initialize_game_test9(Board), 
    printBoard(Board),
    findPlay(Board, ' o ', 2, Moves, 3), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), 
    retract(iPlay(' x ')), !.
%% Author : Reynaud Nicolas (Kaldoran)

% Ce prédicat cherche juste a montrer que l'ia peut déplacer la reine,
% et Qu'elle peut également manger un pion
% ( ici les 2 sont fait a la fois )

% Lancez test1. pour voir le résultat.

initialize_game_test1([ ' w ',' X ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ','   ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	       ' w ',' x ',' w ',' o ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ','   ',' w ',' x ',' w ',' x ',' w ',
				       ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				       '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				      ] ).

test1 :-
    asserta(iPlay(' o ')),
    initialize_game_test1(Board), 
    printBoard(Board),
    findPlay(Board, ' x ', 1, Moves, 1), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), 
    retract(iPlay(' o ')), !.
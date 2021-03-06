%% Author : Reynaud Nicolas (Kaldoran)

% Dans ce cas, l'ia a le choix entre manger 2 pions
% Ou en manger 3, étant donné la statégie aggresive de manger le plus de pion,
% elle choisira d'en manger 3.

% A noter :
%    elle prend le cas ou elle ne se fait pas manger apres.
    
% Lancez test2. pour voir le résultat.

initialize_game_test2([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	       ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				       ' x ',' w ','   ',' w ','   ',' w ',' x ',' w ',' x ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ','   ',' w ','   ',
				       '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       '   ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				       ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				       ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				      ] ).


test2 :-
    asserta(iPlay(' o ')),
    initialize_game_test2(Board), 
    printBoard(Board),
    findPlay(Board, ' x ', 1, Moves, 1), 
    printIaMove(Moves),
    multiMove(Board, Moves, NewBoard),
    printBoard(NewBoard), 
    retract(iPlay(' o ')), !.
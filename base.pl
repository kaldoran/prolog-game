%% Author : Reynaud Nicolas

debug('no').

writeDebug(X) :-
	debug('yes'),
	write(X), !.

writeDebug(_).

isPawn(X) :-
	isRegularPawn(X); isQueen(X).
	
isX(' x ').
isX(' X ').
isO(' o ').
isO(' O ').
    
isRegularPawn(' x ').
isRegularPawn(' o ').
isQueen(' O ').
isQueen(' X ').

isBlack(' n ').
isEmpty('   ').

% Invert the current player
invert_player(' x ', ' o ').
invert_player(' o ', ' x ').

% Transforme a Pawn into Queen Pawn
queen(' o ', ' O ').
queen(' x ', ' X ').

%% --------------------------------------------- %%
%% Convert column and Row into the square number %%
%% --------------------------------------------- %%

convert([Row, Column], Square) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	RowMove is Code - CodeA,
	Square is RowMove * 10 + Column.

% the grid
initialize_game([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' X ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	  ' w ','   ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ','   ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				 ] ).
%% Author : Reynaud Nicolas (Kaldoran)

debug('no').

% Write '+X' if debug mod is on
% ----------------------------- %
writeDebug(X) :-
	debug('yes'),
	write(X), !.

% Else write nothing
% ------------------ %
writeDebug(_).

% Check if '+X' is a Pawn
% I.E if its a regular Pawn or a Queen
% ------------------------------------- %
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

% Check if Pawn is of color Color
% ------------------------------- %
isSameColor(Pawn,Color):-isX(Pawn),isX(Color),!.
isSameColor(Pawn,Color):-isO(Pawn),isO(Color).

% Invert the current player
% ------------------------- %
invert_player(' x ', ' o ').
invert_player(' o ', ' x ').

% Transforme a Pawn into Queen Pawn
% --------------------------------- %
queen(' o ', ' O ').
queen(' x ', ' X ').


%% Convert '+[Row, Column]' into '-Square' 
%% -------------------------------------- %%

convert([Row, Column], Square) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	RowMove is Code - CodeA,
	Square is RowMove * 10 + Column.
	
%% Convert '+Square' into '-[Row, Column]'
%% -------------------------------------- %%
revertConvert([0, Column], Square) :-
    Square =< 10,
    Column is mod(Square, 10), !.
    
revertConvert([Row, Column], Square) :-
    char_code('a', CodeA),
    Column is mod(Square, 10),
    CodeRow is (Square - Column * 10) + CodeA - 1,
    char_code(Row, CodeRow).

% the grid
initialize_game([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	  ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				 ] ).

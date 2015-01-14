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
% I.E if it's a regular Pawn or a Queen
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


% Invert the current player
% ------------------------- %
invert_player(' x ', ' o ').
invert_player(' o ', ' x ').

% Transforme a Pawn into Queen Pawn
% --------------------------------- %
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
initialize_game([ ' w ',' X ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
			 	  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ',' o ',' w ','   ',' w ','   ',' w ','   ',' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				 ] ).
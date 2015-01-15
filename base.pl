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
isBlankSpace('   ').
    
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

% Transform a Pawn into Queen Pawn
% --------------------------------- %
queen(' o ', ' O ').
queen(' x ', ' X ').


% Convert '+[Row, Column]' into '-Square' 
% -------------------------------------- %

convert([Row, Column], Square) :-
	char_code(Row, Code),
	char_code('a', CodeA),
	RowMove is Code - CodeA,
	Square is RowMove * 10 + Column.
	
% Convert '+Square' into '-[Row, Column]'
% -------------------------------------- %
revertConvert([0, Column], Square) :-
    Square =< 10,
    Column is mod(Square, 10), !.
    
    
% Given a '+Square' 
% Output the '[-Row, -Column]' associate to the Square
% ---------------------------------------------------- %
revertConvert([Row, Column], Square) :-
    char_code('a', CodeA),
    ColumnVal is mod(Square, 10),
    (
        ColumnVal \= 0,
        Column = ColumnVal,
        RowCode is Square // 10 + CodeA, !;
        
        Column is ColumnVal + 10,
        RowCode is Square // 10 + CodeA
    ),
    char_code(Row, RowCode).

% the default grid
% ---------------- %
initialize_game([ ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
			 	  ' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',
				  ' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',' x ',' w ',
				  ' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',
				  '   ',' w ','   ',' w ','   ',' w ','   ',' w ','   ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  '   ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',
				  ' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',
				  ' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w ',' o ',' w '
				 ] ).

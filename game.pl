load('global').

startGame(Board) :-
	initialize_game(Board),
	printBoard(Board).

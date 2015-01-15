
findAllRaid(Pawn, Board, ResultR) :-
	findAllRaidBRDiagonal(Pawn, Board, Board, 0, ResultBRD),
	findAllRaidBLDiagonal(Pawn, Board, Board, 0, ResultBLD),
	findAllRaidHRDiagonal(Pawn, Board, Board, 0, ResultHRD),
	findAllRaidHLDiagonal(Pawn, Board, Board, 0, ResultHLD),
	ResultR is ResultBRD + ResultBLD + ResultHRD + ResultHLD.



% finds all Raid in bottom left diagonal (+Pawn, +Board, +Value, -ResultBLD)%
%--------------------------------------------------------------------------%
findAllRaidBLDiagonal(_Pawn, Board, Board, Value, ResultBLD) :-
	length(Board, Len),
	Len #< 22,
	ResultBLD is Value.

findAllRaidBLDiagonal(	Pawn,
						[_|Board],
						[I1, _, _, _, _ , _, _, _, _, I2, _, _, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBLD) :-
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidBLDiagonal(Pawn, Board, Board, NewValue, ResultBLD).
	

findAllRaidBLDiagonal(	Pawn,
						[_|Board],
						[I1, _, _, _, _ , _, _, _, _, I2, _, _, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBLD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidBLDiagonal(Pawn, Board, Board, NewValue, ResultBLD).

findAllRaidBLDiagonal(	Pawn,
						[_|Board],
						_Board,
						Value, 
						ResultBLD) :-
	findAllRaidBLDiagonal(Pawn, Board, Board, Value, ResultBLD).



% finds all Raid in bottom right diagonal (+Pawn, +Board, +Value, -ResultBRD)%
%---------------------------------------------------------------------------%
findAllRaidBRDiagonal(	_Pawn, Board, Board, Value, ResultBRD) :-
	length(Board, Len),
	Len < 24,
	ResultBRD is Value.			

findAllRaidBRDiagonal(	Pawn, 
						[_|Board],
						[I1, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	write("hello"),
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidBRDiagonal(Pawn, Board, Board, NewValue, ResultBRD).

findAllRaidBRDiagonal(	Pawn, 
						[_|Board],
						[I1, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidBRDiagonal(Pawn, Board, Board, NewValue, ResultBRD).

findAllRaidBRDiagonal(	Pawn, 
						[_|Board],
						_Board,
						Value, 
						ResultBRD) :-
	
	findAllRaidBRDiagonal(Pawn, Board, Board, Value, ResultBRD).

% finds all Raid in bottom left diagonal (+Pawn, +Board, +Value, -ResultHLD)%
%--------------------------------------------------------------------------%
findAllRaidHLDiagonal(_Pawn, Board, Board, Value, ResultHLD) :-
	length(Board, Len),
	Len < 24,
	ResultHLD is Value.			

findAllRaidHLDiagonal(	Pawn, 
						[_|Board],
						[I3, _, _, _, _, _, _, _, _, I2, _, _, _, _, _, _, _, _, I1|_],
						Value, 
						ResultHLD) :-
	
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidHLDiagonal(Pawn, Board, Board, NewValue, ResultHLD).

findAllRaidHLDiagonal(	Pawn, 
					[_|Board],
					[I3, _, _, _, _, _, _, _, _, I2, _, _, _, _, _, _, _, _, I1|_],
					Value, 
					ResultHLD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidHLDiagonal(Pawn, Board, Board, NewValue, ResultHLD).

findAllRaidHLDiagonal(	Pawn, 
					[_|Board],
					_Board,
					Value, 
					ResultHLD) :-
	
	findAllRaidHLDiagonal(Pawn, Board, Board, Value, ResultHLD).

% finds all Raid in hight right diagonal (+Pawn, +Board, +Value, -ResultHRD)%
%---------------------------------------------------------------------------%
findAllRaidHRDiagonal( _Pawn, Board,  Board, Value, ResultHRD) :-
	length(Board, Len),
	Len < 24,
	ResultHRD is Value.			

findAllRaidHRDiagonal(	Pawn, 
						[_|Board],
						[I3, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I1|_],
						Value, 
						ResultHRD) :-
	
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidHRDiagonal(Pawn, Board, Board, NewValue, ResultHRD).

findAllRaidHRDiagonal(	Pawn, 
					[_|Board],
					[I3, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I1|_],
					Value, 
					ResultHRD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	NewValue is Value +1,
	findAllRaidHRDiagonal(Pawn, Board, Board, NewValue, ResultHRD).

findAllRaidHRDiagonal(	Pawn, 
					[_|Board],
					_Board,
					Value, 
					ResultHRD) :-
	
	findAllRaidHRDiagonal(Pawn, Board, Board, Value, ResultHRD).
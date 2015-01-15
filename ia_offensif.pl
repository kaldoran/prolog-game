
eval(Board, Value, Pawn) :-
    isX(Pawn),
    findAllRaid(Pawn, Board, Value, ResultRX),
    findAllRaid((X, isO(X)), Board, Value, ResultRO),
    Value is ResultRX - ResultRO, !.
    
eval(Board, Value, Pawn) :-
    isO(Pawn),
    findAllRaid(Pawn, Board, Value, ResultRX),
    findAllRaid((O, isO(O)), Board, Value, ResultRO),
    Value is ResultRO - ResultRX, !.


findAllRaid(Pawn, Board, Value, ResultR) :-
	findAllRaidBRDiagonal(Pawn, Board, Board, ResultBRD),
	findAllRaidBLDiagonal(Pawn, Board, Board, ResultBLD),
	findAllRaidHRDiagonal(Pawn, Board, Board, ResultHRD),
	findAllRaidHLDiagonal(Pawn, Board, Board, ResultHLD),
	ResultR is ResultBRD + ResultBLD + ResultHRD + ResultHLD.



% find all Raid in bottom left diagonal (+Pawn, +Board, +Value, -ResultBLD)%
%--------------------------------------------------------------------------%
findAllRaidBLDiagonal(Pawn, Board, Board, Value, ResultBLD) :-
	length(Board, len),
	len < 22,
	ResultBLD is Value.			

findAllRaidBLDiagonal(	Pawn,
						[Head|Board],
						[I1, _, _, _, _ , _, _, _, _, I2, _, _, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	newValue is Value +1,
	findAllRaidBLDiagonal(Pawn, Board, Board, NewValue, ResultBLD)
	

findAllRaidBLDiagonal(	Pawn,
						[Head|Board],
						[I1, _, _, _, _ , _, _, _, _, I2, _, _, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	newValue is Value +1,
	findAllRaidBLDiagonal(Pawn, Board, Board, NewValue, ResultBLD).

findAllRaidBLDiagonal(	Pawn,
						[Head|Board],
						[I1, _, _, _, _ , _, _, _, _, I2, _, _, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	findAllRaidBLDiagonal(Pawn, Board, Board, NewValue, ResultBLD).



% find all Raid in bottom right diagonal (+Pawn, +Board, +Value, -ResultBRD)%
%---------------------------------------------------------------------------%
findAllRaidBRDiagonal(	Pawn, Board, Board, Value, ResultBRD) :-
	length(Board, len),
	len < 24,
	ResultBRD is Value.			

findAllRaidBRDiagonal(	Pawn, 
						[Head|Board],
						[I1, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	newValue is Value +1,
	findAllRaidBRDiagonal(Pawn, Board, Board, NewValue, ResultBRD).

findAllRaidBRDiagonal(	Pawn, 
						[Head|Board],
						[I1, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	newValue is Value +1,
	findAllRaidBRDiagonal(Pawn, Board, Board, NewValue, ResultBRD).

findAllRaidBRDiagonal(	Pawn, 
						[Head|Board],
						[I1, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I3|_],
						Value, 
						ResultBRD) :-
	
	findAllRaidBRDiagonal(Pawn, Board, Board, NewValue, ResultBRD).

% find all Raid in bottom left diagonal (+Pawn, +Board, +Value, -ResultHLD)%
%--------------------------------------------------------------------------%
findAllRaidHLDiagonal(Pawn, Board, Board, Value, ResultHLD) :-
	length(Board, len),
	len < 24,
	ResultHLD is Value.			

findAllRaidHLDiagonal(	Pawn, 
						[_|Board],
						[I3, _, _, _, _, _, _, _, _, I2, _, _, _, _, _, _, _, _, I1|_],
						Value, 
						ResultHRD) :-
	
	isX(Pawn),
	isX(I1),
	isO(I2),
	isBlankSpace(I3),
	newValue is Value +1,
	findAllRaidHLDiagonal(Pawn, Board, Board, NewValue, ResultHLD).

findAllRaidHLDiagonal(	Pawn, 
					[_|Board],
					[I3, _, _, _, _, _, _, _, _, I2, _, _, _, _, _, _, _, _, I1|_],
					Value, 
					ResultHRD) :-
	
	isO(Pawn),
	isO(I1),
	isX(I2),
	isBlankSpace(I3),
	newValue is Value +1,
	findAllRaidHLDiagonal(Pawn, Board, Board, NewValue, ResultHLD).

findAllRaidHLDiagonal(	Pawn, 
					[_|Board],
					[I3, _, _, _, _, _, _, _, _, I2, _, _, _, _, _, _, _, _, I1|_],
					Value, 
					ResultHRD) :-
	
	findAllRaidHLDiagonal(Pawn, Board, Board, NewValue, ResultHLD).

% find all Raid in hight right diagonal (+Pawn, +Board, +Value, -ResultHRD)%
%---------------------------------------------------------------------------%
findAllRaidBRDiagonal(	Pawn, Board,  Board, Value, ResultBRD) :-
	length(Board, len),
	len < 24,
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
	newValue is Value +1,
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
	newValue is Value +1,
	findAllRaidHRDiagonal(Pawn, Board, Board, NewValue, ResultHRD).

findAllRaidHRDiagonal(	Pawn, 
					[_|Board],
					[I3, _, _, _, _ , _, _, _, _, _, _, I2, _, _, _ , _, _, _, I1|_],
					Value, 
					ResultHRD) :-
	
	findAllRaidHRDiagonal(Pawn, Board, Board, NewValue, ResultHRD).
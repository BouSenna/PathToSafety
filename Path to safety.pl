% Move up 
move([X, Y], [New_X, Y]):-
 X \= 0,
 New_X is X - 1.

% Move down 
move([X, Y], [New_X, Y]):-
 X \= 3,
 New_X is X + 1.

% Move left 
move([X, Y], [X, New_Y]):-
 Y \= 0,
 New_Y is Y - 1.

% Move right
move([X, Y], [X, New_Y]):-
 Y \= 3,
 New_Y is Y + 1.

prohibitable_move([X, Y]):-
 bomb([X, Y]).

preferable_move([X, Y]):-
 star([X, Y]).


find_path(Position, Position, Path, Path, Stars, Stars).

find_path([X,Y], End, Visited, Path, CurrentStars, Stars):-
   move([X, Y], New_Position),
   \+ prohibitable_move(New_Position),
   \+ member(New_Position, Visited),
   (preferable_move(New_Position) -> CurrentStars1 is CurrentStars + 1 ;
                                     CurrentStars1 is CurrentStars),
   find_path(New_Position, End, [New_Position|Visited], Path, CurrentStars1, Stars).
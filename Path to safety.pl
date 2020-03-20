% Move up 
move([X, Y], [New_X, Y], _, _):-
 X \= 0,
 New_X is X - 1.

% Move down 
move([X, Y], [New_X, Y], L, _):-
 X \= L,
 New_X is X + 1.

% Move left 
move([X, Y], [X, New_Y], _, _):-
 Y \= 0,
 New_Y is Y - 1.

% Move right
move([X, Y], [X, New_Y], _, W):-
 Y \= W,
 New_Y is Y + 1.

prohibitable_move([X, Y]):-
 bomb([X, Y]).

preferable_move([X, Y]):-
 star([X, Y]).


% Reverse a list
reverse_list(L, R) :-  
  reverse_list(L, R, []).
reverse_list([], Temp, Temp) :-
  !.
reverse_list([H|T], R, Temp) :- 
  reverse_list(T, R, [H|Temp]). 


find_path(Position, Position, _, _, Path, Path, Stars, Stars).

find_path([X,Y], End, L, W, Visited, Path, CurrentStars, Stars):-
   move([X, Y], New_Position, L, W),
   \+ prohibitable_move(New_Position),
   \+ member(New_Position, Visited),
   (preferable_move(New_Position) -> CurrentStars1 is CurrentStars + 1 ;
                                     CurrentStars1 is CurrentStars),
   find_path(New_Position, End, L, W, [New_Position|Visited], Path, CurrentStars1, Stars).

path_to_safety(Moves, Stars):-
   start_Position(St),
   end_Position(End),
   dim(L, W),
   Length is L - 1,
   Width is W - 1,
   find_path(St, End, Length, Width, [St], Reversed_Moves, 0, Stars),
   reverse_list(Reversed_Moves, Moves).
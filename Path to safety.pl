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

% Comparing the positions to find out the direction
get_direction([X1, Y1], [X2, Y2], Dir):-
  X1 = X2,
  R is Y1 - Y2,
  (R > 0 -> Dir = right ;
            Dir = left).

get_direction([X1, Y1], [X2, Y2], Dir):-
  Y1 = Y2,
  R is X1 - X2,
  (R > 0 -> Dir = down;
            Dir = up).

% Reverse a list
reverse_list(L, R) :-  
  reverse_list(L, R, []).
reverse_list([], Temp, Temp) :-
  !.
reverse_list([H|T], R, Temp) :- 
  reverse_list(T, R, [H|Temp]). 

is_member(Val, [Val|T]).
is_member(Val, [H|T]):-
  is_member(Val, T).

find_path(Position, Position, _, _, Path, Path, Stars, Stars).

find_path([X,Y], End, L, W, Visited, Path, CurrentStars, Stars):-
   move([X, Y], New_Position, L, W),
   \+ prohibitable_move(New_Position),
   \+ is_member(New_Position, Visited),
   (preferable_move(New_Position) -> CurrentStars1 is CurrentStars + 1 ;
                                     CurrentStars1 is CurrentStars),
   find_path(New_Position, End, L, W, [New_Position|Visited], Path, CurrentStars1, Stars).


find_direction([X], DIR, DIR).

find_direction([X, Y|T], Directions, Moves):-
   get_direction(X, Y, New_Dir),
   find_direction([Y|T],[New_Dir|Directions], Moves).

path_to_safety(Moves, Stars):-
   start(St),
   end(End),
   dim(L, W),
   Length is L - 1,
   Width is W - 1,
   find_path(St, End, Length, Width, [St], Positions, 0, Stars), 
   find_direction(Positions, [], Moves).
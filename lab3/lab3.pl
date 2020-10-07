print_res([]):- nl.
print_res([[A,B,Action]|T]):-
	write(A),write(' -> '),
	write(B),write(' : '),
	write(Action),nl,
	print_res(T).

solve_dfs:-
	path_dfs([3,3,left],[0,0,right],[[3,3,left]],MoveList),
	nl, write('Список ходов:'), nl,
	print_res(MoveList).
path_dfs([0,0,right],[0,0,right],_,[]).
path_dfs([A,B,C],[D,E,F],Visited,Moves1):-
	move([A,B,C],[I,J,K],Action),
	write('Try: '), write([I,J,K]),
		write(' '), write(Action), nl,
	safe([I,J,K]),
	not(member([I,J,K],Visited)),
	path_dfs([I,J,K],[D,E,F],[[I,J,K]|Visited],Moves2),
	Moves1 = [[[A,B,C],[I,J,K],Action]|Moves2].

print_bfs([_]):- nl.
print_bfs([A,B|T]):-
	print_bfs([B|T]),
	move(B, A, Action),
	write(B),write(' -> '),
	write(A),write(' : '),
	write(Action), nl.
solve_bfs:-
	path_bfs([[[3,3,left]]],[0,0,right],MoveList),
	nl, write('Список ходов:'), nl,
	print_bfs(MoveList).
help_bfs([A|T],[B,A|T]):-
	move(A,B,_),
	safe(B),
	not(member(B,[A|T])).
path_bfs([[[0,0,right]|T]|_],[0,0,right],[[0,0,right]|T]).
path_bfs([[P|T]|Q],[I,J,K],R):-
	findall(X,help_bfs([P|T],X),L),
	append(Q,L,QQ), !,
	path_bfs(QQ,[I,J,K],R).

solve_id(Max):-
	Max > 0,
	path_id([3,3,left],[0,0,right],[[3,3,left]],MoveList,0,Max),
	nl, write('Список ходов:'),nl,
	print_res(MoveList).
path_id([0,0,right],[0,0,right],_,[],_,_).
path_id([A,B,C],[D,E,F],Visited,Moves1,N,Max):-
	N < Max,
	N1 is N + 1,
	move([A,B,C],[I,J,K],Action),
	write('Try: '), write([I,J,K]),
		write(' '), write(Action), nl,
	safe([I,J,K]),
	not(member([I,J,K],Visited)),
	path_id([I,J,K],[D,E,F],[[I,J,K]|Visited],Moves2,N1,Max),
	Moves1 = [[[A,B,C],[I,J,K],Action]|Moves2].


move([A,B,left],[C,B,right],'1 миссионер переплывает реку'):-
	A > 0, C is A - 1.
move([A,B,left],[C,B,right],'2 миссионера переплывают реку'):-
	A > 1, C is A - 2.
move([A,B,left],[C,D,right],'1 миссионер и 1 каннибал переплывают реку'):-
	A > 0, B > 0, C is A - 1, D is B - 1.
move([A,B,left],[A,D,right],'1 каннибал переплывает реку'):-
	B > 0, D is B - 1.
move([A,B,left],[A,D,right],'2 каннибала переплывают реку'):-
	B > 1, D is B - 2.
move([A,B,left],[C,D,right],'2 миссионера и 1 каннибал переплывают реку'):-
	A > 1, B > 0, C is A - 2, D is B - 1.
move([A,B,left],[C,B,right],'3 миссионера переплывают реку'):-
	A > 2, C is A - 3.
move([A,B,left],[A,D,right],'3 каннибала переплывают реку'):-
	B > 2, D is B - 3.

move([A,B,right],[C,B,left],'1 миссионер переплывает обратно'):-
	A < 3, C is A + 1.
move([A,B,right],[C,B,left],'2 миссионера переплывают обратно'):-
	A < 2, C is A + 2.
move([A,B,right],[C,D,left],'1 миссионер и 1 каннибал переплывают обратно'):-
	A < 3, B < 3, C is A + 1, D is B + 1.
move([A,B,right],[A,D,left],'1 каннибал переплывает обратно'):-
	B < 3, D is B + 1.
move([A,B,right],[A,D,left],'2 каннибала переплывают обратно'):-
	B < 2, D is B + 2.
move([A,B,right],[C,D,left],'2 миссионера и 1 каннибал переплывают обратно'):-
	A < 2, B < 3, C is A + 2, D is B + 1.
move([A,B,right],[C,B,left],'3 миссионера переплывают реку обратно'):-
	A < 1, C is A + 3.
move([A,B,right],[A,D,left],'3 каннибала переплывают реку обратно'):-
	B < 1, D is B + 3.

safe([A,B,_]):-
	(A >= B ; A = 0),
	C is 3 - A, D is 3 - B,%на противоположном берегу
	(C >= D; C = 0).

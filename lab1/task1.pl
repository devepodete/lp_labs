% Первая часть задания - предикаты работы со списками

length1([], 0).
length1([_|T], N):-
	length1(T, N1),
	N is N1 + 1.

member1([X|_], X).
member1([_|Y], X):-
	member1(Y, X).

append1([], X, X).
append1([X|Y], Z, [X|T]):-
	append1(Y, Z, T).

remove1(X, [X|T], T).
remove1(X, [Y|T], [Y|R]):-
	remove1(X, T, R).

permute1([],[]).
permute1(X, R):-
	remove1(Y, X, T),
	permute1(T, T1),
	R = [Y|T1].

sublist1(S, R):-
	append1(X, _, S),
	append1(_, R, X).

%#4
%без стандартных предикатов
count1([], _, 0).
count1([X|T], X, N):-
	count1(T, X, N1),
	N is N1 + 1.
count1([_|T], X, N):-
	count1(T, X, N).

%#4
%со стандартными предикатами
count2([], _, 0).
count2([X|Y], X, N):-
	permute1(Y, T),
	count2(T, X, N1),
	N is N1 + 1.
count2([_|Y], X, N):-
	permute1(Y, T),
	count2(T, X, N1),
	N is N1.

%#5
%без стандартных предикатов
help_max1(X1, X2, Z):-
	(X1 >= X2, Z is X1);
	(X1 < X2, Z is X2).

max1([X], X).
max1([X|Y], N):-
	max1(Y, N1),
	help_max1(X, N1, Z),
	N = Z.

%#5
%со стандартными предикатами
help_max2([H|T], N):-
	N >= H,
	help_max2(T, N).
help_max2([], _).

max2(X, N):-
	remove1(N, X, Y),
	help_max2(Y, N).

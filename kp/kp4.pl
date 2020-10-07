both_father(X, Y, Z):-
	father(Z, X), father(Z, Y).

both_mother(X, Y, Z):-
	mother(Z, X), mother(Z, Y).

%X брат Y
brother(X, Y):-
	sex(X, 'm'),
	both_father(X, Y, _),
	both_mother(X, Y, _),
	X \= Y.

%X сестра Y
sister(X, Y):-
	sex(X, 'f'),
	both_father(X, Y, _),
	both_mother(X, Y, _),
	X \= Y.

grandson_help(X, Y):-
	grandson_help1(X, Y) ; grandson_help2(X, Y).

grandson_help1(X, Y):-
	father(Z, X),
	father(Y, Z).

grandson_help2(X, Y):-
	mother(Z, X),
	father(Y, Z).

%X внук Y
grandson(X, Y):-
	sex(X, 'm'),
	grandson_help(X, Y).

%X внучка Y
granddaughter(X, Y):-
	sex(X, 'f'),
	grandson_help(X, Y).

%X родитель Y
parent(X, Y):-
	father(X, Y) ; mother(X, Y).

%X сын Y
son(X, Y):-
	sex(X, 'm'),
	parent(Y, X).

%X дочь Y
daughter(X, Y):-
	sex(X, 'f'),
	parent(Y, X).

%X дедушка Y
grandfather(X, Y):-
	father(X, Z),
	parent(Z, Y).

%X бабушка Y
grandmother(X, Y):-
	mother(X, Z),
	parent(Z, Y).

%X муж Y
husband(X, Y):-
	father(X, Z),
	mother(Y, Z).

%X жена Y
wife(X, Y):-
	mother(X, Z),
	father(Y, Z).

relative('father', X, Y):- father(X, Y).
relative('mother', X, Y):- mother(X, Y).
relative('brother', X, Y):- brother(X, Y).
relative('sister', X, Y):- sister(X, Y).
relative('husband', X, Y):- husband(X, Y).
relative('wife', X ,Y):- wife(X, Y).
relative('son', X, Y):- son(X, Y).
relative('daughter', X, Y):- daughter(X, Y).
relative('grandson', X, Y):- grandson(X, Y).
relative('granddaughter', X, Y):- granddaughter(X, Y).
relative('grandfather', X, Y):- grandfather(X, Y).
relative('grandmother', X, Y):- grandmother(X, Y).

in_relation(X, Y):-
	father(X, Y);
	mother(X, Y);
	brother(X, Y);
	sister(X, Y);
	son(X, Y);
	daughter(X, Y);
	husband(X, Y);
	wife(X, Y),
	grandfather(X, Y),
	grandmother(X, Y),
	gradson(X, Y),
	granddaughter(X, Y).
	
names_to_relations([X, Y], [R]):-
	relative(R, X, Y).
names_to_relations([X, Y|T], [P, Q|R]):-
	relative(P, X, Y),
	names_to_relations([Y|T], [Q|R]), !.

%поиск в глубину
prolong([X|T], [Y, X|T]):-
	in_relation(X, Y),
	not(member(Y, [X|T])).
path1([X|T], X, [X|T]).
path1(L, Y, R):-
	prolong(L, T),
	path1(T, Y, R).
dfs(X, Y, R2):-
	path1([X], Y, R1),
	names_to_relations(R1, R2).

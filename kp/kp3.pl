sex(X, m):-
	father(X, _).

sex(X, f):-
	mother(X, _).

both_father(X, Y, Z):-
	father(Z, X), father(Z, Y).

both_mother(X, Y, Z):-
	mother(Z, X), mother(Z, Y).

%X брат Y
brother(X, Y):-
	sex(X, m),
	both_father(X, Y, _),
	both_mother(X, Y, _),
	X \= Y.

%X сестра Y
sister(X, Y):-
	sex(X, f),
	both_father(X, Y, _),
	both_mother(X, Y, _),
	X \= Y.

%X муж Y
husband(X, Y):-
	father(X, Z),
	mother(Y, Z),
	sex(X, m).

%X жена Y
wife(X, Y):-
	father(Y, Z),
	mother(X, Z),
	sex(X, f).

%золовка - сестра мужа
%X золовка Y
zolovka(X, Y):-
	wife(Y, Z),
	sister(X, Z).

:-op(20, xfx, ':').
an_morph(L, morph(Pristavka, Koren, Okonchanie, Rod, Chislo)):-
	append(T1, L3, L),
	append(L1, L2, T1),

	an_pristavka(L1, Pristavka),
	an_koren(L2, Koren),
	an_okonchanie(L3, Okonchanie),
	an_rod(L3, Rod),
	an_chislo(L3, Chislo).

fid(XC, X, File):-
	member(M, File),
	condition(XC, X, M).

condition(XC, X, X:XC).

an_pristavka(X, prist(X1)):-
	pristavka_list(L),
	fid(X1, X, L).

an_koren(X, kor(X1)):-
	koren_list(L),
	fid(X1, X, L).

an_okonchanie(X, okon(X1)):-
	okonchanie_list(L),
	fid(X1, X, L).

an_rod([X], rod(X1)):-
	rod_list(L),
	fid(X1, X, L).
an_rod([_|T], rod(X1)):-
	an_rod(T, rod(X1)).

an_chislo([X], chislo(X1)):-
	chislo_list(L),
	fid(X1, X, L).
an_chislo([_|T], chislo(X1)):-
	an_chislo(T, chislo(X1)).


pristavka_list(L):-
L=[
['з','а']:'за',
['и','з']:'из',
['в','ы']:'вы',
['о','б']:'об',
['п','е','р','е']:'пере',
['н','е','д','о']:'недо'
].

koren_list(L):-
L=[
['у','ч']:'уч'
].

okonchanie_list(L):-
L=[
['и','л']:'ил',
['и','т']:'ит',
['и','л','а']:'ила',
['и','л','о']:'ило',
['и','л','и']:'или'
].

rod_list(L):- L=[
'а':'женский',

'о':'средний',

'л':'мужской',
'т':'мужской',
'и':'неопределенный'
].

chislo_list(L):- L=[
'и':'множественное',

'а':'единственное',
'о':'единственное',
'л':'единственное',
'т':'единственное'
].

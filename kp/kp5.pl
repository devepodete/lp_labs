%Does X Y of Z
q1(L1, L2, L3, L4, L5):-
	an_question(L1),
	an_prist(L4),
	answer1(L3, L2, L5).

%Who is X of Y
q2(L1, L2, L3, L4, L5):-
	an_question(L1),
	an_is(L2),
	answer2(L3, P, L5).


check(L):-
	append(T1, T2, L),
	append(L1, T3, T1),
	append(L2, L3, T3),
	append(L4, L5, T2),

	(q1(L1, L2, L3, L4, L5) ; q2(L1, L2, L3, L4, L5)).


an_question([X]):-
	question_list(L),
	member(X, L).

an_prist([X]):-
	prist_list(L),
	member(X, L).

an_is([X]):-
	is_list(L),
	member(X, L).

question_list(L):-
	L = ['Does', 'does', 'Who', 'who']. 

prist_list(L):-
	L = ['of'].

is_list(L):-
	L = ['is', 'are'].

answer1([Relation], [Member1], [Member2]):-
	relative(Relation, Member1, Member2),
	write('Yes, '), write(Member1), write(' is '), write(Relation), write(' of '), write(Member2), nl.

answer1([Relation], [Member1], [Member2]):-
	not(relative(Relation, Member1, Member2)),
	atomic(Relation),
	write('No, '), write(Member1), write(' is not '), write(Relation), write(' of '), write(Member2), nl.

answer1([Relation], [Member1], [Member2]):-
	not(relative(Relation, Member1, Member2)),
	not(atomic(Relation)),
	write('No, '), write(Member1), write(' is not in relation with anybody'), nl.

answer2([Relation], [Member1], [Member2]):-
	relative(Relation, Member1, Member2),
	write(Member1), write(' is '), write(Relation), write(' of '), write(Member2), nl.

remove1(X, [X|T], T).
remove1(X, [Y|T], [Y|R]):-
	remove1(X, T, R).

permute1([],[]).
permute1(X, R):-
	remove1(Y, X, T),
	permute1(T, T1),
	R = [Y|T1].

blood_realtion('муж', 'сын').
blood_realtion('сын', 'муж').
blood_realtion('жена', 'сын').
blood_realtion('сын', 'жена').
blood_realtion('муж', 'сестра мужа').
blood_realtion('сестра мужа', 'муж').
blood_realtion('жена', 'отец жены').
blood_realtion('отец жены', 'жена').

child('муж', 'сын').
child('жена', 'сын').
child('отец жены', 'жена').

has_brother('сестра мужа', 'муж').

wife('муж', 'жена').

older('муж', 'сын').
older('жена', 'сын').
older('отец жены', 'жена').
older('отец жены', 'сын').

%неизвестные данные
older('муж', 'жена').
older('муж', 'отец жены').
older('муж', 'сестра мужа').
older('жена', 'муж').
older('жена', 'сестра мужа').
older('сестра мужа', 'муж').
older('сестра мужа', 'жена').
older('сестра мужа', 'отец жены').
older('сестра мужа', 'сын').
older('отец жены', 'муж').
older('отец жены', 'сестра мужа').
older('сын', 'сестра мужа').

younger('муж', 'жена').
younger('муж', 'отец жены').
younger('муж', 'сестра мужа').
younger('жена', 'муж').
younger('жена', 'сестра мужа').
younger('сестра мужа', 'муж').
younger('сестра мужа', 'жена').
younger('сестра мужа', 'отец жены').
younger('сестра мужа', 'сын').
younger('отец жены', 'муж').
younger('отец жены', 'сестра мужа').
younger('сын', 'сестра мужа').

profession(_, 'инженер').
profession(_, 'юрист').	
profession(_, 'слесарь').	
profession(_, 'экономист').	
profession(_, 'учитель').

write_answer(X1, X2, X3, X4, X5):-
	write(X1), write(" - "), write("инженер"), nl,
	write(X2), write(" - "), write("юрист"), nl,
	write(X3), write(" - "), write("слесарь"), nl,
	write(X4), write(" - "), write("экономист"), nl,
	write(X5), write(" - "), write("учитель"), nl.

solve:-
	People = [X1, X2, X3, X4, X5],
	permute1(People, ['муж', 'жена', 'сын', 'отец жены', 'сестра мужа']),

	profession(X1, 'инженер'),	
	profession(X2, 'юрист'),	
	profession(X3, 'слесарь'),	
	profession(X4, 'экономист'),	
	profession(X5, 'учитель'),

	%завязаны на профессиях
	has_brother(X1, XX1),
	wife(XX1, XX2),
	older(X1, XX2),
	not(blood_realtion(X2, X5)),
	child(X4, X3),
	younger(X1, X5),
	older(X4, X3),
	write_answer(X1, X2, X3, X4, X5).

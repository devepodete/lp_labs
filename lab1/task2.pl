% Task 2: Relational Data

%#############################################################
%Вспомогательные предикаты

%удаление повторяющихся, взял из интернета
remove_duplicates([], []):-!.
remove_duplicates([X|Xs], Ys):-
      member(X, Xs),
      !, remove_duplicates(Xs, Ys).
remove_duplicates([X|Xs], [X|Ys]):-
      !, remove_duplicates(Xs, Ys).

%сумма элементов в списке
sum_list([], 0).
sum_list([H|T], N):-
	sum_list(T, N1),
	N is H + N1.

%#############################################################
%1.1
task1():-
	findall(Group, grade(Group, _, _, _), Groups),
	remove_duplicates(Groups, S),
	help_1(S).

help_1([]).
help_1([H|T]):-
	findall(Stud, grade(H, Stud, _, _), Students1),
	remove_duplicates(Students1, Students2),
	findall(Mark, grade(H, _, _, Mark), Marks),
	length(Marks, Len),
	sum_list(Marks, Sum),
	Avg is Sum/Len,
	write(H), write(': '), write(Students2), write(' avg: '), write(Avg), nl, 
	help_1(T).
	
%#############################################################
%1.2
task2():-
	findall(Sub, grade(_, _, Sub, _), Subjects),
	remove_duplicates(Subjects, S),
	help_2(S).
	
help_2([]).
help_2([H|T]):-
	write(H), write(': '),
	findall(Stud, grade(_, Stud, H, 2), L1),
	write(L1), nl,
	help_2(T).

%#############################################################
%1.3
task3():-
	findall(Group, grade(Group, _, _, _), Groups),
	remove_duplicates(Groups, S),
	help_3(S).

help_3([]).
help_3([H|T]):-
	findall(Student, grade(H, Student, _, 2), Students1),
	remove_duplicates(Students1, Students2),
	length(Students2, Count),
	write(H), write(': '), write(Count), nl,
	help_3(T).
%#############################################################

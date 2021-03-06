# Отчет по курсовому проекту
## по курсу "Логическое программирование"

### студент: Черемисинов М.Л.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |     14.12.19         |     5-          |
| Левинская М.А.|              |               |

> В задании 5 не реализованы грамматики. 

## Введение

Надеюсь, что курсовой проект поможет разобраться с принципами работы логических языков программирования, научит решать задачи кардинально другими способами.  

## Задание

 1. Создать родословное дерево своего рода на несколько поколений (3-4) назад в стандартном формате GEDCOM с использованием сервиса MyHeritage.com 
 2. Преобразовать файл в формате GEDCOM в набор утверждений на языке Prolog, используя следующее представление: ...
 3. Реализовать предикат проверки/поиска .... 
 4. Реализовать программу на языке Prolog, которая позволит определять степень родства двух произвольных индивидуумов в дереве
 5. [На оценки хорошо и отлично] Реализовать естественно-языковый интерфейс к системе, позволяющий задавать вопросы относительно степеней родства, и получать осмысленные ответы. 

## Получение родословного дерева

Сделал дерево на сайте myheritage.com. В первоначальной версии было 60, через пару дней больше 110. Скачал в формате GEDCOM.

## Конвертация родословного дерева

Python3. Простой в использовании, как по мне, отлично подошел для парсинга текста конкретно в этой задаче. 
Принцип работы:
1. Из файла с расширением .ged считываются строки и остаются только те, которые содержат в себе поля "NAME", "FAMS", "FAMC" или "SEX". 
2. Удаляются те люди, имена которых неизвестны. Также удаляются неизвестные фамилии.
```
for i in range(len(res)-1, 0, -1):
		if res[i][0] != "NAME":
			k = k + 1
		else:
			if (len(res[i][1]) == 0) or ("?" in res[i][1]):
				while k >= 0:
					del res[i]
					k = k - 1
			k = 0
for i in range(0, len(res)):
		for k in range (0, len(res[i])):
			res[i][k] = res[i][k].replace("\n", "")
		if res[i][0] == "NAME":
			if not("//" in res[i][2] or "?" in res[i][2]):
				res[i][2] = res[i][2].replace("/", "")
				res[i][1] = res[i][1] + " " + res[i][2]
			del res[i][2]
```
3. Имена записываются транслитом
```
for i in range(0, len(res)):
		if res[i][0] == "NAME":
			res[i][1] = translit(res[i][1])
```
4. Заполняется окончательный массив "семей", где "семья" - это массив вида [номер_семьи, [родители], [дети]].
5. Выполняется обход массива, и для каждого ребенка генерируется строка вида father(отец, ребенок) или mother(мать, ребенок) в зависимости от пола родителя.
6. Команды сортируются по первому символу и записываются в выходной файл, который называется "familyTree.pl".
```
strings.sort(key = lambda st: st[0])
	for i in strings:
		outputFile.write(i)
```

Важное замечание. При такой конвертации, когда человека характеризуют только его родители, теряется часть информации о дереве (люди без родителей).

## Предикат поиска родственника

Важное замечание. При подобном парсинге невозможно определить, являются ли 2 человека парой, если у них нет детей.
В файле "kp3.pl" описаны все необходимые предикаты для определения золовки.
```prolog
%золовка - сестра мужа
%X золовка Y
zolovka(X, Y):-
	wife(Y, Z),
	sister(X, Z).
```

## Определение степени родства

Определение степени родства сделал через поиск в глубину. Ищутся все возможные "пути" от одного человека к другому, затем при помощи предиката `names_to_relations` имена переводятся в отношения родства. Все предикаты описаны в файле kp4.pl.
```prolog
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
```

## Естественно-языковый интерфейс

При помощи предикатов из предыдущих пунктов КП реализовал простой естественно-языковой интерфейс, в котором запросы могут быть заданы в виде:
* ```check(['Does', 'Tatyana', 'wife', 'of', 'Leonid'])```
* ```check(['Who', 'is', 'wife', 'of', 'Tatyana'])```
* ```check(['Does', X, Y, 'of', Z])```

Ответы выдаются в виде:
* `Yes, Tatyana Zykova is wife of Leonid Cheremisinov`
* `No, Tatyana is not sister of Lev`
* `No, Maksim is not in relation with anybody`

**Замечание:** В некоторых случаях выдается несколько одинаковых ответов в виду определения пола человека через его детей (mother, father).

## Выводы

Курсовой проект, на мой взгляд, состоит из очень интересных заданий: составить генеалогическое дерево, отпарсить его, определить степень родства двух любых людей, "нестандартное родство", научиться отвечать на более-менее человекоподобные вопросы.

По ходу выполнения заданий начал смотреть под другим углом на привычные для меня вещи: сам стиль решения задач и подход к написанию программ. Местами было трудно, но в конечном итоге все знания о языке Prolog собрались в одну общую картину, и стало очевидно, что многие задачи куда проще решаются на логических языках программирования.

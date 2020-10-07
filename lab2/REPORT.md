#№ Отчет по лабораторной работе №2
## по курсу "Логическое программирование"

## Решение логических задач

### студент: Черемисинов М.Л.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|    14.11     |      4        |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*: не все решения получены (+ экономист играет в футбол подразумевало факт, что экономист - мужчина)


## Введение

На мой взгляд, два самых распространенных метода решения логических задач - это полный перебор и метод исключения.
В первом случае просто перебираются все возможные варианты, и для какого-либо конкретного значения проверяется истинность остальных высказываний.
Во втором случае можно попытаться сразу определить противоречащие друг другу случаи и отсечь их, благодаря чему сузить количество возможных вариантов.

Сама структура логических задач построена на высказываниях, которые достаточно легко переносятся на логику предикатов, с которой и работает Prolog. Благодаря чему достаточно описать все высказывания из задачи, а Prolog выведет для нее все решения, если такие имеются.

## Задание

В семье Семеновых пять человек: муж, жена, их сын, сестра мужа и отец жены. Все они работают. Один инженер, другой юрист, третий слесарь, четвертый экономист, пятый учитель. Вот что еще известно о них. Юрист и учитель не кровные родственники. Слесарь хороший спортсмен. Он пошел по стопам экономиста и играет в футбол за сборную завода. Инженер старше жены своего брата, но моложе, чем учитель. Экономист старше, чем слесарь. Назовите профессии каждого члена семьи Семеновых.

## Принцип решения

Данные по задаче перевел в логику предикатов:
`blood_relation(X,Y)` - X кровный родственник Y,
`child(X, Y)` - X ребенок Y,
`older(X, Y)` - X старше Y.

Для перебора профессий объявил их подобным образом:
`profession(_, 'инженер').`

Осуществляется полный перебор людей и их профессий.

```prolog
  People = [X1, X2, X3, X4, X5],
	permute1(People, ['муж', 'жена', 'сын', 'отец жены', 'сестра мужа']),

	profession(X1, 'инженер'),	
	profession(X2, 'юрист'),	
	profession(X3, 'слесарь'),	
	profession(X4, 'экономист'),	
	profession(X5, 'учитель'),
```

Поскольку о некоторых людей недостаточно информации о возрасте (например, кто кого старше), то для таких случаев использовал предикаты `older` и `yonger` для их обоих.
Например:
```prolog
older('муж', 'жена').
older('жена', 'муж').
younger('муж', 'жена').
younger('жена', 'муж').
```
Обойтись одним предикатом `older` нельзя, поскольку во время поиска решения используется его отрицание.

Если подходящий набор найден - печатает его.

## Выводы

В задаче получается два непротивречащих внтри себя решения:

|   муж   |    жена   |   сын   | сестра мужа | отец жены |
|---------|-----------|---------|-------------|-----------|
| учитель | экономист | слесарь |   инженер   |   юрист   |
|  юрист  | экономист | слесарь |   инженер   |  учитель  |


Пример возрастов для обоих решений:
Муж - 40, жена - 20, сын - 1, сестра мужа - 30, отец жены - 50.

Для уменьшения количества переборов в некоторых задачах (как и в моей), можно ставить самые редко встречающиеся предикаты раньше тех, которых подходят большему числу переменных. (`has_brother` стоит раньше остальных, так как подходит только одному человеку и т.д.).

Prolog позволяет решать логические задачи, которые в свою очередь в большинстве случаев достаточно просто переносятся на язык логики предикатов. В некоторых ситуациях, когда размеры задачи выходят за пределы разумного, или когда полный перебор подручными средствами не представляется возможным, без языка, использующего логическую парадигму программирования, обойтись  становится достаточно проблематично.
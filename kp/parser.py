import sys

def translit(string):
    capital_letters = {
        u'А': u'A',
        u'Б': u'B',
        u'В': u'V',
        u'Г': u'G',
        u'Д': u'D',
        u'Е': u'E',
        u'Ё': u'E',
        u'Ж': u'Zh',
        u'З': u'Z',
        u'И': u'I',
        u'Й': u'Y',
        u'К': u'K',
        u'Л': u'L',
        u'М': u'M',
        u'Н': u'N',
        u'О': u'O',
        u'П': u'P',
        u'Р': u'R',
        u'С': u'S',
        u'Т': u'T',
        u'У': u'U',
        u'Ф': u'F',
        u'Х': u'KH',
        u'Ц': u'Ts',
        u'Ч': u'Ch',
        u'Ш': u'Sh',
        u'Щ': u'Sch',
        u'Ъ': u'',
        u'Ы': u'Y',
        u'Ь': u'',
        u'Э': u'E',
        u'Ю': u'Yu',
        u'Я': u'Ya'
    }

    lower_case_letters = {
        u'а': u'a',
        u'б': u'b',
        u'в': u'v',
        u'г': u'g',
        u'д': u'd',
        u'е': u'e',
        u'ё': u'e',
        u'ж': u'zh',
        u'з': u'z',
        u'и': u'i',
        u'й': u'y',
        u'к': u'k',
        u'л': u'l',
        u'м': u'm',
        u'н': u'n',
        u'о': u'o',
        u'п': u'p',
        u'р': u'r',
        u'с': u's',
        u'т': u't',
        u'у': u'u',
        u'ф': u'f',
        u'х': u'kh',
        u'ц': u'ts',
        u'ч': u'ch',
        u'ш': u'sh',
        u'щ': u'sch',
        u'ъ': u'',
        u'ы': u'y',
        u'ь': u'',
        u'э': u'e',
        u'ю': u'yu',
        u'я': u'ya'
    }

    translit_string = ""

    for index, char in enumerate(string):
        if char in lower_case_letters.keys():
            char = lower_case_letters[char]
        elif char in capital_letters.keys():
            char = capital_letters[char]
            if len(string) > index+1:
                if string[index+1] not in lower_case_letters.keys():
                    char = char.upper()
            else:
                char = char.upper()
        translit_string += char

    return translit_string

if(len(sys.argv) != 2):
	print("Usage: python3 "+ sys.argv[0] + " .GED-FILE")
else:
	res = []
	gedFile = open(sys.argv[1], "r")
	for line in gedFile:
		for each in ["NAME", "FAMS", "FAMC", "SEX", "MARNM"]:
			if each in line:
				res.append(line)
	gedFile.close()
	for i in range (0, len(res)):
		kek = res[i].split(' ')
		del kek[0]
		res[i] = kek
		for k in range(len(res[i])):
			res[i][k] = res[i][k].replace("\n", "")

	k = 0
	for i in range(len(res)-1, 0, -1):
		if res[i][0] != "NAME":
			k = k + 1
		else:
			if (len(res[i][1]) == 0) or ("?" in res[i][1]):
				while k >= 0:
					del res[i]
					k = k - 1
			k = 0

	for i in range(len(res)):	
		if res[i][0] == "NAME":
			if res[i+1][0] == "_MARNM" and not ("?" in res[i+1][1] or "//" in res[i+1][1]):
				res[i][1] = res[i][1] + " " + res[i+1][1]
			else:
				if not("//" in res[i][2] or "?" in res[i][2]):
					res[i][2] = res[i][2].replace("/", "")
					res[i][1] = res[i][1] + " " + res[i][2]
				
			del res[i][2]

	for i in range(0, len(res)):
		if res[i][0] == "NAME":
			res[i][1] = translit(res[i][1])

	families = []
	current_name = ""
	current_sex = ""
	for elem in res:		
		if elem[0] == "NAME":
			current_name = elem[1]
			continue
		if elem[0] == "SEX":
			current_sex = elem[1]
			continue
		found = False
		index = 0
		for familyIndex in range(len(families)):
			if families[familyIndex][0] == elem[1]:
				found = True
				index = familyIndex
				break

		if found == True:
			if elem[0] == "FAMS":
				families[index][1].append([current_name, current_sex])
			else:
				families[index][2].append([current_name, current_sex])
		else:
			families.append([])
			families[-1].append(elem[1])
			families[-1].append([])
			families[-1].append([])
			if elem[0] == "FAMS":
				#parent
				families[-1][1].append([current_name, current_sex])
			else:
				#child
				families[-1][2].append([current_name, current_sex])


	outputFile = open("familyTree.pl", "w")
	strings = []
	for family in families:
		if len(family[2]) == 0:
			continue
		ok1, ok2 = True, True
		for child in family[2]:
			for parent in family[1]:
				if parent[1] == "M":
					strings.append("father(\'" + parent[0] + "\', \'" + child[0] + "\').\n")
				else:
					strings.append("mother(\'" + parent[0] + "\', \'" + child[0] + "\').\n")
	
	strings.sort(key = lambda st: st[0])
	for i in strings:
		outputFile.write(i)

	outputFile.close()
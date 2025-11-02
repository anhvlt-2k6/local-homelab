str = '358bd1a4f2cf7300d48b93c17590afea499b648e'
str_sep = ''

for i in range(len(str)):
    str_sep += str[i]
    if i % 2 != 0:
        str_sep += ':'
        
print(str_sep[:len(str_sep) - 1])
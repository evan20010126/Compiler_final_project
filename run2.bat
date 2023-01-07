bison -d example2.y
flex example2.l
gcc example2.tab.c lex.yy.c -lfl
a.exe

del example2.tab.c
del lex.yy.c
del a.exe
del example2.tab.h
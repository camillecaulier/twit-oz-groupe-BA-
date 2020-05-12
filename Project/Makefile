#CC=/Applications/Mozart2.app/Contents/Resources/bin/ozc
#EXEC=/Applications/Mozart2.app/Contents/Resources/bin/ozengine

 
all : main.oza maintemp.oza
main.oza : main.oz Reader.ozf Algo.ozf
	#$(CC) -c main.oz -o main.oza
	ozc -c main.oz -o main.oza
maintemp.oza : maintemp.oz Reader.ozf Algo.ozf
	ozc -c maintemp.oz -o maintemp.oza

%.ozf : %.oz
	#$(CC) -c $< -o $@
	ozc -c $< -o $@
run : main.oza
	#$(EXEC) main.oza
	ozengine main.oza

maintemp : maintemp.oza
	ozengine maintemp.oza
clean :
	rm -f *.oza *.ozf
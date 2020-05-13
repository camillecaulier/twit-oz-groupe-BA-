#CC=/Applications/Mozart2.app/Contents/Resources/bin/ozc
#EXEC=/Applications/Mozart2.app/Contents/Resources/bin/ozengine

 
all : main.oza 
main.oza : main.oz Reader.ozf Algo.ozf
	ozc -c main.oz -o main.oza

#maintemp.oza : maintemp.oz Reader.ozf Algo.ozf
	#ozc -c maintemp.oz -o maintemp.oza

%.ozf : %.oz
	ozc -c $< -o $@

run : main.oza
	ozengine main.oza

#runtemp : maintemp.oza
	#ozengine maintemp.oza
clean :
	rm -f *.oza *.ozf
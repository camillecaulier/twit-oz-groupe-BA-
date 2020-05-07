CC=/Applications/Mozart2.app/Contents/Resources/bin/ozc
EXEC=/Applications/Mozart2.app/Contents/Resources/bin/ozengine

all : main.oza
main.oza : main.oz Reader.ozf Algo.ozf
	$(CC) -c main.oz -o main.oza
%.ozf : %.oz
	$(CC) -c $< -o $@
run : main.oza
	$(EXEC) main.oza
clean :
	rm -f *.oza *.ozf
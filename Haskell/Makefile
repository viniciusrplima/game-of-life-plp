
EXEC_FILE=game-of-life
MAIN_FILE=Main.hs

default: *.hs
	ghc $(MAIN_FILE) -o $(EXEC_FILE)

run: 
	./$(EXEC_FILE)

clean:
	rm *.o *.hi $(EXEC_FILE)

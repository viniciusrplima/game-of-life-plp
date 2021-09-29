:- initialization(main).
:- include('Utils.pl').
:- include('Screen.pl').
:- include('Patterns.pl').
:- include('Gol.pl').
:- include('Credits').
:- include('MatrixView').


title(["█▀▀ ▄▀█ █▀▄▀█ █▀▀   █▀█ █▀▀   █   █ █▀▀ █▀▀", 
       "█▄█ █▀█ █ ▀ █ ██▄   █▄█ █▀    █▄▄ █ █▀  ██▄"]).

menu(["Start   ", 
      "What is?",
      "Credits ", 
      "Quit    "]).

commandsTable([" s / w - mover cursor  ", 
               " f - selecionar        "]).
                   

   
printMenu(MenuTab):-

    width(Width),
    height(Height),
    emptyPxl(EmptyPxl),
    solidPxl(SolidPxl),
    title(Title),
    commandsTable(CommandsTable),
    pattern("Glider Flower", GliderFlower),
    createEmptyMatrix(10, 10, LargeMatrix),
    mergeMatrixCentralized(GliderFlower,LargeMatrix,InitialLogoMatrix),
    matrixToBuffer(SolidPxl, InitialLogoMatrix, FlowerBuf),

    createScreenBuffer(Width, Height, EmptyPxl, InitialBuffer),
    createBufferFromStringMatrix(Title, TitleBuf),
    createBufferFromStringMatrix(MenuTab, MenuBuf),
    createBufferFromStringMatrix(CommandsTable, TableBuf),

    renderCentralized(TitleBuf,InitialBuffer, 5, 0, Tmp1),
    renderCentralized(MenuBuf, Tmp1, 10, 0, Tmp2),
    renderInBuffer(TableBuf, Tmp2, 3, 1, Tmp3),
    renderCentralized(FlowerBuf, Tmp3, (-7), 0, Tmp4),
    
    printScreen(Tmp4).

printArrow([],_,[]).

printArrow([Row|Rest],I,R):-
    (I =:= 0, 
     string_concat(Row," <<<",X),
     string_concat(" ", X, Z),
     R = [Z|Rest];
     N is I-1,
     I >=0,
     printArrow(Rest, N, Z),
     R = [Row|Z]).


mainLoop(Index):-

    MaxIndex = 4, 
    menu(Menu),
    printArrow(Menu, Index, MenuTab),
    printMenu(MenuTab),
    

    waitKey(['w','s','f'], Key),  
    
    (Key = 'w', NewIndex = ((Index - 1) + MaxIndex) mod MaxIndex;
	 Key = 's', NewIndex = ((Index + 1) + MaxIndex) mod MaxIndex;
     Key = 'f', Index =:= 0, matrixView;
     Key = 'f', Index =:= 1, write("Coisa que acontece no What is");
     Key = 'f', Index =:= 2, credits;
    Key = 'f', Index =:= 3, halt),

    mainLoop(NewIndex).
    
main:- mainLoop(0).


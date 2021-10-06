textoTutorial( [
    "                 O Game of Life é um autômato celular desenvolvido pelo matemático britânico John Horton Conway em 1970.",
    " ",
    "        Ele foi criado para reproduzir, através de regras simples, as alterações em grupos de seres vivos com o passar das gerações.",
    " ",
    " As regras definidas são aplicadas a cada nova geração, assim, a partir de um padão de células definida pelo jogador, percebem-se mudanças",
    "                              muitas vezes inesperadas a cada nova geração, variando de padrões fixos a caóticos.",
    " ",
    " ",
    " Neste modelo, a representação de células vivas é dada por pixels brancos, enquanto as células mortas são representadas por pixels pretos."]
).

menuTutorial( [
    " Quais são as regras? <<<"  
    ]).

commandsTableTutorial( [
    " f - selecionar        ",
    " q - voltar            "]).

printTutorial:-

    textoTutorial(Texto),
    commandsTableTutorial(CommandsTable),
    width(Width),
    height(Height),
    emptyPxl(EmptyPxl),
    menuTutorial(Menu),
    createScreenBuffer(Width, Height, EmptyPxl, InitialBuffer ),
    createBufferFromStringMatrix(Texto, TextoBuf),
    createBufferFromStringMatrix(Menu, MenuBuf),
    createBufferFromStringMatrix(CommandsTable, TableBuf),
    
    renderCentralized(TextoBuf,InitialBuffer, 0, 0, Tmp1),
    renderCentralized(MenuBuf, Tmp1,10, 0, Tmp2),
    renderInBuffer(TableBuf, Tmp2, 3, 1, Tmp3),
    printScreen(Tmp3).


tutorial:-

  printTutorial,
  waitKey(['q','f'], Key),  

    (Key = 'q', mainLoop(1);
	 Key = 'f', rulesLoop(0)).
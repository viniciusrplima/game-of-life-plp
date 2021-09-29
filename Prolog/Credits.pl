:- initialization(main).
:- include('Utils.pl').
:- include('Screen.pl').
texto([
    "Projeto para disciplina Paradigmas de Linguagens de Programação, ministrada pelo professor Everton Alves.", 
    "  ", 
    "Criado para linha de comando com base no autómato celular Conway's Game of life.", 
    " ", 
    "Código escito por: ", 
    " ",
    " Vinicius Rodrigues Pacheco de Lima",
    " Luan Carvalho Pedrosa",
    " Hiago Willyam Araújo Lacerda e", 
    " Isaías do Nascimento Silva",
    " ",
    " Em Agosto de 2021."]).


menuCredit([
    "Voltar para o menu <<<"]).

commandsTableCredit([ 
    " f - selecionar        "]).

printCredits:-

    width(Width),
    height(Height),
    menuCredit(MenuCredit),
    texto(Texto),
    emptyPxl(EmptyPxl),
    commandsTableCredit(CommandsTableCredit),

    createScreenBuffer(Width, Height, EmptyPxl, InitialBuffer),
    createBufferFromStringMatrix(Texto, TextoBuf),
    createBufferFromStringMatrix(MenuCredit, MenuBuf),
    createBufferFromStringMatrix(CommandsTableCredit, TableBuf),

    renderCentralized(TextoBuf,InitialBuffer, -1, 0, Tmp1),
    renderCentralized(MenuBuf, Tmp1, 14, 0, Tmp2),
    renderInBuffer(TableBuf, Tmp2, 3, 1, Tmp3),
  
    printScreen(Tmp3).
    
credits:- 

    printCredits,
    waitKey(['f'], Key),  
    Key = 'f',
    main.

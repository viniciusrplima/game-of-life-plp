:-initialization(main).
:-use_module(Screen).

menu(
    "----------------------------\n
     --         GOL            --\n
     ----------------------------\n"
).

printMenu :- 
    menu(Menu), 
    Screen.colorizeString(Menu, 'bg-red', MenuStr),

    write(MenuStr), 

    read_line_to_string(user_input, Cmd), 

    printMenu.

main :- printMenu.
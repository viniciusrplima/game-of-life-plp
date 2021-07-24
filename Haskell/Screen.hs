module Screen where

import Text.Printf
import System.IO

--   Tipo     Construtor    Atributos
data IPixel = Pixel         [Char] Int -- Content, Color
-- criando novo objeto
-- Pixel "ABC" 33


-- ****************************
--  COLORS
-- ****************************

-- retorna o codigo da cor
-- os codigos das cores do terminal sao representados por inteiros
getColor :: [Char] -> Int
getColor "white"    = 29
getColor "black"    = 30
getColor "red"      = 31
getColor "green"    = 32
getColor "yellow"   = 33
getColor "blue"     = 34
getColor "purple"   = 35
getColor "leaf"     = 36
getColor "bg-gray"  = 40
getColor "bg-red"   = 41
getColor "bg-green" = 42
getColor "bg-yellow"= 43
getColor "bg-blue"  = 44
getColor "bg-purple"= 45
getColor "bg-leaf"  = 46
getColor "bg-white" = 47
getColor clr = error ("Cor '" ++ clr ++ "' nao existe")


-- colore uma string
-- usando o codigo das cores e concatenando tudo podemos ter uma string colorida
-- no terminal
colorizeString :: [Char] -> [Char] -> [Char]
colorizeString text color = colorizeStringByCode text (getColor color)

colorizeStringByCode :: [Char] -> Int -> [Char]
colorizeStringByCode text color = ("\x1b[" ++ (show color) ++ "m" ++ text ++ "\x1b[0m")



-- ****************************
--  BUFFERS
-- ****************************

-- cria uma matrix de strings que serve como buffer para
-- imprimir na tela
createScreenBuffer :: Int -> Int -> [Char] -> [[IPixel]]
createScreenBuffer w h c = createScreenBufferColored w h c "white"

-- cria uma matrix de strings colorida
createScreenBufferColored :: Int -> Int -> [Char] -> [Char] -> [[IPixel]]
createScreenBufferColored w h c color = replicate h $ replicate w $ (Pixel c (getColor color))

-- imprime buffer no buffer
renderInBuffer :: [[IPixel]] -> [[IPixel]] -> Int -> Int -> [[IPixel]]
renderInBuffer buffer source x y
    | length buffer == 0    = buffer
    | length source == 0    = buffer
    | y <= 0                = renderInBufferRow bufferFirst sourceFirst x : renderInBuffer bufferTail sourceTail x y
    | otherwise             = bufferFirst : renderInBuffer bufferTail source x (pred y)
    where bufferFirst = head buffer
          bufferTail = tail buffer 
          sourceFirst = head source
          sourceTail = tail source

-- imprime string em outra string
renderInBufferRow :: [IPixel] -> [IPixel] -> Int -> [IPixel]
renderInBufferRow target source i 
    | length source == 0= target
    | i >= length target= target
    | i <= 0            = sourceFirst : renderInBufferRow targetTail sourceTail 0
    | otherwise         = targetFirst : renderInBufferRow targetTail source (pred i) 
    where targetFirst = head target
          targetTail = tail target
          sourceFirst = head source
          sourceTail = tail source

-- converte string em buffer
stringToBufferColor :: [Char] -> Int -> Int -> [IPixel]
stringToBufferColor "" _ _ = []
stringToBufferColor source step color  = do
    let rest = drop step source
    let content = take step $ source ++ (repeat ' ')
    (Pixel content color) : stringToBufferColor rest step color

stringToBuffer :: [Char] -> Int -> [Char] -> [IPixel]
stringToBuffer source step color = stringToBufferColor source step (getColor color)

createBufferFromStringMatrix :: [[Char]] -> Int -> [Char] -> [[IPixel]]
createBufferFromStringMatrix [] _ _ = []
createBufferFromStringMatrix (row:source) step color = do
    stringToBuffer row step color : createBufferFromStringMatrix source step color

-- ****************************
--  PRINT SCREEN
-- ****************************

-- renderiza um buffer na tela utilizando
-- buffer na saída do terminal
printScreen :: [[IPixel]] -> IO()
printScreen buffer = do
    hSetBuffering stdout (BlockBuffering Nothing)
    printScreenStd buffer
    hSetBuffering stdout LineBuffering

-- renderiza um buffer na tela
printScreenStd :: [[IPixel]] -> IO()
printScreenStd [] = putStrLn ""
printScreenStd (row:buffer) = do 
    printRowScreenStd row
    printScreenStd buffer


-- renderiza uma linha do buffer na tela
printRowScreenStd :: [IPixel] -> IO()
printRowScreenStd [] = printf "\n"
printRowScreenStd ((Pixel content color):row) = do
    printf $ colorizeStringByCode content color
    printRowScreenStd row


-- ****************************
--  TESTS
-- ****************************


printMyBuffer = do
    let initial = createScreenBuffer 20 20 "  "
    let rect = createScreenBufferColored 15 10 "░░" "blue"
    let otherRect = createScreenBufferColored 15 10 "██" "blue"
    let tmp = renderInBuffer initial rect 2 2
    let tmp2 = renderInBuffer tmp otherRect 3 3
    let menu = ["-- GOL --", "1) Start", "2) Records", "3) Quit"]
    let menuBuffer = createBufferFromStringMatrix menu 2 "red"
    let final = renderInBuffer tmp2 menuBuffer 4 4
    printScreen final
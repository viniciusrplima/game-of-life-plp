module Screen where

import Text.Printf
import System.IO

import qualified Gol
import qualified Terminal
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)

--   Tipo     Construtor    Atributos
data IPixel = Pixel         [Char] Int -- Content, Color
-- criando novo objeto
-- Pixel "ABC" 33

pixelWidth = 2

termSize = unsafeDupablePerformIO Terminal.getTermSize
termHeight = fst termSize
termWidth = snd termSize
width = termWidth `div` pixelWidth
height = termHeight

emptyPxl = replicate pixelWidth ' '
shadowPxl = replicate pixelWidth '░'
solidPxl = replicate pixelWidth '█'

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

-- largura de um buffer, maior largura entre todas as linhas
bufferWidth :: [[IPixel]] -> Int
bufferWidth buffer = maximum $ map length buffer

bufferHeight :: [[IPixel]] -> Int
bufferHeight buffer = length buffer

-- imprime um buffer no centro de outro
renderInCenter :: [[IPixel]] -> [[IPixel]] -> [[IPixel]]
renderInCenter buffer source = renderCentralized buffer source 0 0

-- imprime um buffer no centro de outro com um deslocamento
renderCentralized :: [[IPixel]] -> [[IPixel]] -> Int -> Int -> [[IPixel]]
renderCentralized buffer source offsetX offsetY = do
    let x = (bufferWidth buffer) `div` 2 - (bufferWidth source) `div` 2 + offsetX
    let y = (bufferHeight buffer) `div` 2 - (bufferHeight source) `div` 2 + offsetY
    renderInBuffer buffer source x y

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

-- cria uma matrix de pixels a partir de uma lista de strings
createBufferFromStringMatrix :: [[Char]] -> [Char] -> [[IPixel]]
createBufferFromStringMatrix [] _ = []
createBufferFromStringMatrix (row:source) color = do
    stringToBuffer row pixelWidth color : createBufferFromStringMatrix source color

-- ****************************
--  PRINT SCREEN
-- ****************************

bufferToString :: [[IPixel]] -> [Char]
bufferToString [] = ""
bufferToString (row:buffer) = bufferRowToString row ++ bufferToString buffer

bufferRowToString :: [IPixel] -> [Char]
bufferRowToString [] = "\n"
bufferRowToString ((Pixel content color):row)= do
    colorizeStringByCode content color ++ bufferRowToString row

-- renderiza um buffer na tela utilizando
-- buffer na saída do terminal
printScreen :: [[IPixel]] -> IO()
printScreen buffer = do
    hSetBuffering stdout (BlockBuffering Nothing)
    putStrLn $ bufferToString buffer
    hFlush stdout
    hSetBuffering stdout LineBuffering

bufferToStringPerformed :: [[IPixel]] -> [Char]
bufferToStringPerformed [] = ""
bufferToStringPerformed (row:buffer) = bufferRowToStringPerformed row ++ bufferToStringPerformed buffer

bufferRowToStringPerformed :: [IPixel] -> [Char]
bufferRowToStringPerformed [] = "\n"
bufferRowToStringPerformed ((Pixel content color):row)= do
    content ++ bufferRowToStringPerformed row

-- aumenta a performance da impressao pois ignora as cores dos pixels
printScreenPerformed :: [[IPixel]] -> [Char] -> IO()
printScreenPerformed buffer color = do
    hSetBuffering stdout (BlockBuffering Nothing)
    putStrLn $ colorizeStringByCode (bufferToStringPerformed buffer) (getColor color)
    hFlush stdout
    hSetBuffering stdout LineBuffering

-- ****************************
--  GOL UTILS
-- ****************************

matrixToBuffer :: [[Int]] -> [Char] -> [Char] -> [[IPixel]]
matrixToBuffer matrix content color = matrixToBufferColored matrix content (getColor color)

matrixToBufferColored :: [[Int]] -> [Char] -> Int -> [[IPixel]]
matrixToBufferColored [] _ _ = []
matrixToBufferColored (row:matrix) content color = matrixRowToBufferRow row content color : matrixToBufferColored matrix content color

matrixRowToBufferRow :: [Int] -> [Char] -> Int -> [IPixel]
matrixRowToBufferRow [] _ _ = []
matrixRowToBufferRow (cell:row) content color = createPixelFromGolCell cell content color : matrixRowToBufferRow row content color

createPixelFromGolCell :: Int -> [Char] -> Int -> IPixel
createPixelFromGolCell cell content color
    | cell == Gol.deadCell = Pixel (replicate (length content) ' ') color
    | otherwise = Pixel content color

-- ****************************
--  TESTS
-- ****************************

myMenu = [
    "-- GOL --", 
    "1) Start   ", 
    "2) Records ", 
    "3) Quit    "]

createMenu :: [[Char]] -> Int -> [[Char]]
createMenu [] i = []
createMenu (row:menu) 0 = (row ++ "<--") : menu
createMenu (row:menu) i = row : createMenu menu (pred i)

printMyBuffer i = do
    let initial = createScreenBuffer 20 20 "  "
    let rect = createScreenBufferColored 15 10 "░░" "blue"
    let otherRect = createScreenBufferColored 15 10 "██" "blue"
    let tmp = renderInBuffer initial rect 2 2
    let tmp2 = renderInBuffer tmp otherRect 3 3
    let menu = createMenu myMenu i
    let menuBuffer = createBufferFromStringMatrix menu "bg-blue"
    let final = renderInBuffer tmp2 menuBuffer 6 6 

    printScreen final

    hSetBuffering stdin NoBuffering
    command <- getChar 
    hSetBuffering stdin LineBuffering

    if (command == 'w') then do
        let prevI = if i == 1 then 3 else (pred i)
        printMyBuffer prevI
    else do
        let nextI = if i == 3 then 1 else (succ i)
        printMyBuffer nextI
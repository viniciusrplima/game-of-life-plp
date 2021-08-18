module PatternSelect where


import qualified Screen as Screen
import qualified MatrixView as MatrixView
import qualified Terminal
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent

termSize = unsafeDupablePerformIO Terminal.getTermSize
termHeight = fst termSize
termWidth = snd termSize

pixelWidth = 2

emptyPxl = replicate pixelWidth ' '
shadowPxl = replicate pixelWidth '░'
solidPxl = replicate pixelWidth '█'

initialBuffer = Screen.createScreenBuffer (termWidth `div` pixelWidth) termHeight emptyPxl

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let menuColor = "blue"
    let shadow = Screen.createScreenBufferColored 40 25 shadowPxl menuColor
    let rect = Screen.createScreenBufferColored 40 25 solidPxl menuColor
    let menuBuf = Screen.createBufferFromStringMatrix menuTab pixelWidth "bg-blue"
    let tableBuf = Screen.createBufferFromStringMatrix commandsTable pixelWidth "bg-red"

    let tmp1 = Screen.renderInBuffer initialBuffer shadow 15 5
    let tmp2 = Screen.renderInBuffer tmp1 rect 16 6
    let tmp3 = Screen.renderInBuffer tmp2 menuBuf 23 10
    let tmp4 = Screen.renderInBuffer tmp3 tableBuf 1 3

    Screen.printScreen tmp4

selecionaPadrao :: [[Char]]
selecionaPadrao = [
    "Glider ", 
    "Dart ", 
    "64P2H1V0 ",
    "Brain ", 
    "Turtle ", 
    "Sidecar ", 
    "Swan ", 
    "Orion ", 
    "Crab ", 
    "Wing ", 
    "Hammerhead ", 
    "Lightweight Spaceship ", 
    "Loafer ", 
    "Copperhead ", 
    "B-heptomino ", 
    "Pi-heptomino "
    
    ]

commandsTable :: [[Char]]
commandsTable = [
    "                       ", 
    " s / w - mover cursor  ", 
    " f - selecionar        ",  
    "                       "]

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (row ++ "<<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 16
    let offset = 0

    printMenu $ printArrow selecionaPadrao (index + offset)
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w' -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index


    if command == 'f' then MatrixView.printMatrixView termWidth termHeight index -- iniciar jogo
 
    else putStrLn ""       -- continua no menu

    mainLoop newIndex


main :: IO()
main = mainLoop 0
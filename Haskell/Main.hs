
import qualified Screen as Screen
import qualified Terminal
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import Control.Concurrent

termSize = unsafeDupablePerformIO Terminal.getTermSize
termHeight = fst termSize
termWidth = snd termSize

pixelWidth = 2

emptyPxl = replicate pixelWidth ' '
shadowPxl = replicate pixelWidth '░'
solidPxl = replicate pixelWidth '█'

initialBuffer = Screen.createScreenBuffer (termWidth `div` pixelWidth) termHeight emptyPxl

menu :: [[Char]]
menu = [
    "██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██", 
    "  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ", 
    "                                                  ",
    "               ██████ ██████ █                    ", 
    "               █      █    █ █                    ", 
    "               █    █ █    █ █                    ", 
    "               ██████ ██████ ██████               ", 
    "                                                  ", 
    "██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██", 
    "  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ", 
    "                                                  ", 
    "                                                  ", 
    "                     Start    ", 
    "                     Records  ", 
    "                     Quit     ", 
    "                                                  ", 
    "                                                  "]


commandsTable :: [[Char]]
commandsTable = [
    "                       ", 
    " s / w - mover cursor  ", 
    " f - selecionar        ", 
    " ctrl+c - sair do jogo ", 
    "                       "]


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

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (row ++ "<<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 3
    let offset = 12

    printMenu $ printArrow menu (index + offset)
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w' -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index

    if command =='f' && index == 2 then putStrLn "QUIT" -- desistir da partida
    else mainLoop newIndex                               -- continua no menu

main :: IO()
main = mainLoop 1

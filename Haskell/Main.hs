
import qualified Screen as Scr
import qualified MatrixView as Mv
import qualified PatternSelect as Ps
import qualified Terminal
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent

initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl

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
    "                       "]


-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let menuColor = "blue"
    let shadow = Scr.createScreenBufferColored 40 25 Scr.shadowPxl menuColor
    let rect = Scr.createScreenBufferColored 40 25 Scr.solidPxl menuColor
    let menuBuf = Scr.createBufferFromStringMatrix menuTab "bg-blue"
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable "bg-red"

    let tmp1 = Scr.renderInBuffer initialBuffer shadow 15 5
    let tmp2 = Scr.renderInBuffer tmp1 rect 16 6
    let tmp3 = Scr.renderInBuffer tmp2 menuBuf 23 10
    let tmp4 = Scr.renderInBuffer tmp3 tableBuf 1 3

    Scr.printScreen tmp4

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

    if command == 'f' && index == 2 then exitSuccess   -- desistir da partida
    else if command == 'f' && index == 0 then Mv.printMatrixView -- iniciar jogo
    else putStrLn ""       -- continua no menu

    mainLoop newIndex


main :: IO()
main = mainLoop 0

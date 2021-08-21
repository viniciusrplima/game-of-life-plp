
import qualified Screen as Scr
import qualified MatrixView as Mv
import qualified PatternSelect as Ps
import qualified Terminal
import qualified Patterns as Ptn
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent
import qualified Gol

title :: [[Char]]
title = [
    "█▀▀ ▄▀█ █▀▄▀█ █▀▀   █▀█ █▀▀   █   █ █▀▀ █▀▀", 
    "█▄█ █▀█ █ ▀ █ ██▄   █▄█ █▀    █▄▄ █ █▀  ██▄"]

menu :: [[Char]]
menu = [
    "Start   ", 
    "Records ", 
    "Quit    "]

commandsTable :: [[Char]]
commandsTable = [
    " s / w - mover cursor  ", 
    " f - selecionar        "]

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let titleBuf = Scr.createBufferFromStringMatrix title "white"
    let menuBuf = Scr.createBufferFromStringMatrix menuTab "white"
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable "white"
    let flowerBuf = Scr.matrixToBuffer Ptn.gliderFlower Scr.solidPxl "white"

    let tmp1 = Scr.renderCentralized initialBuffer titleBuf 0 5
    let tmp2 = Scr.renderCentralized tmp1 menuBuf 0 10
    let tmp3 = Scr.renderInBuffer tmp2 tableBuf 1 3
    let tmp4 = Scr.renderCentralized tmp3 flowerBuf 0 (-5)

    Scr.printScreenPerformed tmp4 "white"

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (row ++ " <<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 3

    printMenu $ printArrow menu index
    
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

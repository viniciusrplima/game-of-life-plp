import qualified Screen as Scr
import qualified MatrixView as Mv
import qualified PatternSelect as Ps
import qualified Terminal
import qualified Patterns as Ptn
import qualified Gol
import qualified Credits as Crdt
import qualified Tutorial as Ttrl
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent

title :: [[Char]]
title = [
    "█▀▀ ▄▀█ █▀▄▀█ █▀▀   █▀█ █▀▀   █   █ █▀▀ █▀▀", 
    "█▄█ █▀█ █ ▀ █ ██▄   █▄█ █▀    █▄▄ █ █▀  ██▄"]

menu :: [[Char]]
menu = [
    "Start   ", 
    "What is?",
    "Credits ", 
    "Quit    "]

commandsTable :: [[Char]]
commandsTable = [
    " s / w - mover cursor  ", 
    " f - selecionar        "]

animationIters :: Int
animationIters = 30

animationDelay :: Int
animationDelay = 30000

initialLogoMatrix :: [[Int]]
initialLogoMatrix = do
    let largeMatrix = Gol.createEmptyMatrix 25 25
    let patternMatrix = Gol.mergeMatrixCentralized Ptn.gliderFlower largeMatrix
    patternMatrix

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let titleBuf = Scr.createBufferFromStringMatrix title
    let menuBuf = Scr.createBufferFromStringMatrix menuTab
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    let flowerBuf = Scr.matrixToBuffer initialLogoMatrix Scr.solidPxl

    let tmp1 = Scr.renderCentralized initialBuffer flowerBuf 0 (-7)
    let tmp2 = Scr.renderCentralized tmp1 menuBuf 0 10
    let tmp3 = Scr.renderInBuffer tmp2 tableBuf 1 3
    let tmp4 = Scr.renderCentralized tmp3 titleBuf 0 5

    Scr.printScreen tmp4

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (" " ++ row ++ " <<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

flowerAnimation :: [[Int]] -> Int -> IO()
flowerAnimation _ 0 = Mv.printMatrixView
flowerAnimation logoPattern iter = do
    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let patternBuf = Scr.matrixToBuffer logoPattern Scr.solidPxl
    let finalBuffer = Scr.renderCentralized initialBuffer patternBuf 0 (-7)

    Scr.printScreen finalBuffer
    threadDelay animationDelay -- espera por um momento

    flowerAnimation (Gol.advanceMatrix logoPattern) (iter-1)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 4

    printMenu $ printArrow menu index
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w' -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index


    if command == 'f' && index == 3 then exitSuccess   -- desistir da partida
    else if command =='f' && index == 2 then Crdt.main 
    else if command == 'f' && index == 1 then Ttrl.main
    else if command == 'f' && index == 0 then flowerAnimation initialLogoMatrix animationIters -- iniciar jogo
    else putStrLn ""       -- continua no menu

    mainLoop newIndex


main :: IO()
main = mainLoop 0

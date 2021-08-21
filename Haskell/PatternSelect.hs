module PatternSelect where

import qualified Screen as Scr
import qualified Terminal
import qualified Patterns as Ptn
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent

initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let shadow = Scr.createScreenBufferColored 40 25 Scr.shadowPxl
    let rect = Scr.createScreenBufferColored 40 25 Scr.solidPxl
    let menuBuf = Scr.createBufferFromStringMatrix menuTab
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable

    let tmp1 = Scr.renderInBuffer initialBuffer shadow 15 5
    let tmp2 = Scr.renderInBuffer tmp1 rect 16 6
    let tmp3 = Scr.renderInBuffer tmp2 menuBuf 23 10
    let tmp4 = Scr.renderInBuffer tmp3 tableBuf 1 3

    Scr.printScreen tmp4

-- retorna a lista com todos os nomes dos padroes
createPatternsList :: [[Char]]
createPatternsList = map fst Ptn.patterns

findPattern :: Int -> [[Int]]
findPattern idx = snd $ Ptn.patterns !! idx

commandsTable :: [[Char]]
commandsTable = [
    "                       ", 
    " s / w - mover cursor  ", 
    " f - selecionar        ",  
    "                       "]

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (row ++ " <<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: ([[Int]] -> [[Int]] -> IO()) -> [[Int]] -> Int -> IO()
mainLoop func matrix index = do
    let maxIndex = length Ptn.patterns
    let offset = 0

    printMenu $ printArrow createPatternsList (index + offset)
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w' -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index

    if command == 'f' then func matrix $ findPattern index
    else mainLoop func matrix newIndex

-- recebe uma funcao de callback que ira receber o
-- e a matrix atual
selectPattern :: ([[Int]] -> [[Int]] -> IO()) -> [[Int]] -> IO()
selectPattern func matrix = mainLoop func matrix 0

module Rules where

import qualified Screen as Scr
import qualified MatrixView as Mv
import qualified PatternSelect as Ps
import qualified Terminal
import qualified Patterns as Ptn
import qualified Gol as Gol
import qualified PatternsofRules as Ptnrls
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent
 

title :: [[Char]]
title = ["Seleciona alguma regra para ver sua exemplificação"]

menu :: [[Char]]
menu = [
    "1. Qualquer célula viva com menos de dois vizinhos vivos morre de solidão             ",
    "2. Qualquer célula viva com mais de três vizinhos vivos morre de superpopulação       ",
    "3. Qualquer célula com exatamente três vizinhos vivos se torna uma célula viva        ",
    "4. Qualquer célula com dois vizinhos vivos continua no mesmo estado na próxima geração"]

commandsTable :: [[Char]]
commandsTable = [
    " s / w - mover cursor  ", 
    " f - selecionar        ",
    " q - Voltar"]

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do

    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let textoBuf = Scr.createBufferFromStringMatrix title
    let menuBuf = Scr.createBufferFromStringMatrix menuTab
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    
    let tmp1 = Scr.renderCentralized initialBuffer textoBuf 0 0
    let tmp2 = Scr.renderCentralized tmp1 menuBuf 0 10
    let tmp3 = Scr.renderInBuffer tmp2 tableBuf 1 3
    
    Scr.printScreen tmp3 

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (" "++ row ++ " <<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 4
    let primeiroExemplo = Ptnrls.first 
    let segundoExemplo = Ptnrls.second
    let terceiroExemplo = Ptnrls.third
    let quartoExemplo = Ptnrls.fourth
    printMenu $ printArrow menu index 
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w' -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index
    

    
    if command == 'f' && index == 3 then Ptnrls.printRuleFour
    else if command =='f' && index == 2 then  Ptnrls.printRuleThree 
    else if command =='f' && index == 1 then Ptnrls.printRuleTwo
    else if command =='f' && index == 0 then Ptnrls.printRuleOne
    else putStrLn " "
    
    if command /= 'q' then mainLoop newIndex
    else putStrLn " "
    
    
main :: IO()
main = mainLoop 0

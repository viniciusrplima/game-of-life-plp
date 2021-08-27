module Tutorial where

import qualified Screen as Scr
import qualified MatrixView as Mv
import qualified PatternSelect as Ps
import qualified Terminal
import qualified Patterns as Ptn
import qualified Rules as Rls
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent

texto:: [[Char]]
texto = [
    "                 O Game of Life é um autômato celular desenvolvido pelo matemático britânico John Horton Conway em 1970.",
    " ",
    "        Ele foi criado para reproduzir, através de regras simples, as alterações em grupos de seres vivos com o passar das gerações.",
    " ",
    " As regras definidas são aplicadas a cada nova geração, assim, a partir de um padão de células definida pelo jogador, percebem-se mudanças",
    "                              muitas vezes inesperadas a cada nova geração, variando de padrões fixos a caóticos.",
    " ",
    " ",
    " Neste modelo, a representação de células vivas é dada por pixels brancos, enquanto as células mortas são representadas por pixels pretos."]

menu :: [[Char]]
menu = [
    "Quais são as regras?", 
    "Voltar para o menu" 
    ]

commandsTable :: [[Char]]
commandsTable = [
    " s / w - mover cursor  ", 
    " f - selecionar        "]

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do

    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let textoBuf = Scr.createBufferFromStringMatrix texto
    let menuBuf = Scr.createBufferFromStringMatrix menuTab
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    let flowerBuf = Scr.matrixToBuffer Ptn.gliderFlower Scr.solidPxl

    let tmp1 = Scr.renderCentralized initialBuffer textoBuf 0 0
    let tmp2 = Scr.renderCentralized tmp1 menuBuf 0 10
    let tmp3 = Scr.renderInBuffer tmp2 tableBuf 1 3
    

    Scr.printScreen tmp3

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (" " ++ row ++ " <<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 2

    printMenu $ printArrow menu index 
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w'  -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index
    

    if command == 'f' && index == 1 then putStrLn " "
    else if command =='f' && index == 0 then Rls.main
    else mainLoop newIndex


main :: IO()
main = mainLoop 0

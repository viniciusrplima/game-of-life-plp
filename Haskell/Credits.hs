module Credits where

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

texto :: [[Char]]
texto = [
    "Projeto para disciplina Paradigmas de Linguagens de Programação, ministrada pelo professor Everton Alves.", 
    "  ", 
    "Criado para linha de comando com base no autómato celular Conway's Game of life.", 
    " ", 
    "Código escito por: ", 
    " ",
    " Vinicius Rodrigues Pacheco de Lima",
    " Luan Carvalho Pedrosa",
    " Hiago Willyam Araújo Lacerda e", 
    " Isaías do Nascimento Silva",
    " ",
    " Em Agosto de 2021."]

menu :: [[Char]]
menu = [
    "Voltar para o menu <<<"]

commandsTable :: [[Char]]
commandsTable = [ 
    " f - selecionar        "]

-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let textoBuf = Scr.createBufferFromStringMatrix texto
    let menuBuf = Scr.createBufferFromStringMatrix menuTab
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable

    let tmp1 = Scr.renderCentralized initialBuffer textoBuf 0 1
    let tmp2 = Scr.renderCentralized tmp1 menuBuf 0 10
    let tmp3 = Scr.renderInBuffer tmp2 tableBuf 1 3
  

    Scr.printScreen tmp3

mainLoop :: Int -> IO()
mainLoop index = do

    printMenu $ menu 

    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- processa o comando recebido
    case command of 'f' -> putStrLn " "
                    cmd -> mainLoop 0
 


main :: IO()
main = mainLoop 0

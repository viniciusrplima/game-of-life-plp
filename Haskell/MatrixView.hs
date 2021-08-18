module MatrixView where

import qualified Screen as Scr
import qualified Gol
import qualified Patterns as Ptn
import qualified PatternSelect as Ps
import qualified PatternLocate as Pl
import Text.Printf
import System.IO
import Control.Concurrent

-- constants
matrixColor = "white"

menuOpcoes :: [[Char]]
menuOpcoes = [
    " f - avanca                      ", 
    " c - limpar matrix               ",
    " s - selecionar padrao           ",
    " q - voltar para o menu inicial  "]

-- imprime a tela principal
printHUD :: [[Int]] -> IO()
printHUD matrix = do
    let matrixBuffer = Scr.matrixToBuffer matrix Scr.solidPxl matrixColor
    let menuBuf = Scr.createBufferFromStringMatrix menuOpcoes matrixColor

    -- imprime menu dentro da matrix
    let window = Scr.renderInBuffer matrixBuffer menuBuf 5 5
    
    -- imprime na tela de forma performatica
    Scr.printScreenPerformed window matrixColor

selectPatternHandle :: [[Int]] -> [[Int]] -> IO()
selectPatternHandle matrix pattern = Pl.locatePattern printMatrixViewRecursive matrix pattern

printMatrixViewRecursive :: [[Int]] -> IO()
printMatrixViewRecursive matrix = do

    printHUD matrix

    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- processa o comando recebido
    case command of 'f' -> printMatrixViewRecursive (Gol.advanceMatrix matrix)
                    'q' -> putStrLn " "
                    's' -> Ps.selectPattern selectPatternHandle matrix
                    'c' -> printMatrixViewRecursive (Gol.createEmptyMatrix Scr.width Scr.height)
                    cmd -> printMatrixViewRecursive matrix

-- imprime a tela da matriz do jogo
printMatrixView :: IO()
printMatrixView = do

    -- inicializa matriz vazia
    let emptyMatrix = Gol.createEmptyMatrix Scr.width Scr.height

    printMatrixViewRecursive emptyMatrix

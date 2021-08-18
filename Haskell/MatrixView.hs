module MatrixView where

import qualified Screen as Screen
import qualified Gol
import qualified Patterns as Ptn
import Text.Printf
import System.IO
import Control.Concurrent

-- constants
pixelSize = 2
matrixContent = '█'
matrixColor = "white"

-- cria um pixel, replicando uma letra n numero de vezes
makePixel :: Char -> Int -> [Char]
makePixel character numVezes = replicate numVezes character

menuOpcoes :: [[Char]]
menuOpcoes = [
    " f - avanca                       ", 
    " c - limpar matrix                ",
    " q - voltar para a tela de seleção "]

-- imprime a tela principal
printHUD :: [[Int]] -> IO()
printHUD matrix = do
    let matrixBuffer = Screen.matrixToBuffer matrix (makePixel matrixContent pixelSize) matrixColor
    let menuBuf = Screen.createBufferFromStringMatrix menuOpcoes pixelSize matrixColor

    -- imprime menu dentro da matrix
    let window = Screen.renderInBuffer matrixBuffer menuBuf 5 5
    
    -- imprime na tela de forma performatica
    Screen.printScreenPerformed window matrixColor

printMatrixViewRecursive :: [[Int]] -> Int -> Int -> IO()
printMatrixViewRecursive matrix width height = do

    printHUD matrix

    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- processa o comando recebido
    case command of 'f' -> printMatrixViewRecursive (Gol.advanceMatrix matrix) width height
                    'q' -> putStrLn " "
                    'c' -> printMatrixViewRecursive (Gol.createEmptyMatrix width height) width height
                    cmd -> printMatrixViewRecursive matrix width height

-- imprime a tela da matriz do jogo
printMatrixView :: Int -> Int -> Int-> IO()
printMatrixView termWidth termHeight index = do
    let width = termWidth `div` pixelSize
    let height = termHeight
    let idx = index
    print "index"
    -- inicializa matriz vazia
    let emptyMatrix = Gol.createEmptyMatrix width height

    -- adiciona padrao na matriz
    
    let tmp1 = Gol.mergeMatrix (Ptn.patterns !! idx) emptyMatrix 20 20
    
    printMatrixViewRecursive tmp1 width height 

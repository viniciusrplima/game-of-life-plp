module MatrixView where

import qualified Screen as Screen
import qualified Gol
import qualified Patterns as Ptn
import Text.Printf
import System.IO
import Control.Concurrent

-- constants
pixelSize = 2
menuColor = "bg-blue"
matrixContent = '█'
matrixColor = "bg-green"

-- cria um pixel, replicando uma letra n numero de vezes
makePixel :: Char -> Int -> [Char]
makePixel character numVezes = replicate numVezes character

menuOpcoes :: [[Char]]
menuOpcoes = [
    " a - avanca                       ", 
    " s - selecionar padrao            ", 
    " q - voltar para a tela principal "]

-- imprime a tela principal
printHUD :: [[Int]] -> Int -> Int -> IO()
printHUD matrix termWidth height = do
    let width = termWidth `div` pixelSize

    let matrixBuffer = Screen.matrixToBuffer matrix (makePixel matrixContent pixelSize) matrixColor
    let window = Screen.createScreenBuffer width height "  "
    let menuBuf = Screen.createBufferFromStringMatrix menuOpcoes pixelSize menuColor

    -- imprime na tela
    let tmp1 = Screen.renderInBuffer window matrixBuffer 20 5 -- matriz
    let tmp2 = Screen.renderInBuffer tmp1 menuBuf 5 5 -- menu
    Screen.printScreen tmp2

printMatrixViewRecursive :: [[Int]] -> Int -> Int -> IO()
printMatrixViewRecursive matrix termWidth termHeight = do

    printHUD matrix termWidth termHeight

    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    case command of 'a' -> printMatrixViewRecursive (Gol.advanceMatrix matrix) termWidth termHeight
                    'q' -> putStrLn "Menu Principal" -- volta para o menu principal
                    cmd -> printMatrixViewRecursive matrix termWidth termHeight

-- imprime a tela da matriz do jogo
printMatrixView :: Int -> Int -> IO()
printMatrixView termWidth termHeight = do
    -- inicializa matriz vazia
    let emptyMatrix = Gol.createEmptyMatrix 40 30

    -- adiciona padrao na matriz
    let tmp1 = Gol.mergeMatrix Ptn.dart emptyMatrix 0 0
    let tmp2 = Gol.mergeMatrix Ptn.dart tmp1 15 15

    printMatrixViewRecursive tmp2 termWidth termHeight

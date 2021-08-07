module MatrixView where

import qualified Screen as Screen
import Text.Printf
import System.IO

pixelSize = 2

-- cria um pixel, replicando uma letra n numero de vezes
makePixel :: Char -> Int -> [Char]
makePixel character numVezes = replicate numVezes character

menuOpcoes :: [[Char]]
menuOpcoes = [
    " a / z - avanca / retrocede       ", 
    " s - selecionar padrao            ", 
    " q - voltar para a tela principal "]

-- imprime a tela principal
printHUD :: Int -> Int -> IO()
printHUD termWidth height = do
    let width = termWidth `div` pixelSize

    let borderColor = "bg-red"
    let borderPixel = makePixel '#' pixelSize
    let borderSize = 1

    let menuColor = "bg-blue"

    -- imprime as bordas da matrix
    let border = Screen.createScreenBufferColored width height borderPixel borderColor
    let matrix = Screen.createScreenBufferColored (width-2*borderSize) (height-2*borderSize) (makePixel ' ' pixelSize) "white"

    let menuBuf = Screen.createBufferFromStringMatrix menuOpcoes pixelSize menuColor

    -- imprime na tela
    let tmp1 = Screen.renderInBuffer border matrix borderSize borderSize
    let tmp2 = Screen.renderInBuffer tmp1 menuBuf 5 5
    Screen.printScreen tmp2

-- imprime a tela da matriz do jogo
printMatrixView :: Int -> Int -> IO()
printMatrixView termWidth termHeight = do

    printHUD termWidth termHeight

    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    case command of 'q' -> putStrLn "Menu Principal" -- volta para o menu principal
                    cmd -> printMatrixView termWidth termHeight
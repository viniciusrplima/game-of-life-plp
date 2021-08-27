module PatternLocate where

import qualified Gol
import qualified Screen as Scr
import System.IO

menu :: [[Char]]
menu = [
    " f - adicionar             ", 
    " a - esquerda              ", 
    " d - direita               ", 
    " w - cima                  ", 
    " s - baixo                 ", 
    " r - rotacionar a direita  ", 
    " l - rotacionar a esquerda ", 
    " q - cancelar              "]

locatePatternRec :: ([[Int]] -> IO()) -> [[Int]] -> [[Int]] -> Int -> Int -> IO()
locatePatternRec func matrix pattern row col = do
    let mergedMatrix = Gol.mergeMatrixHighlight pattern matrix row col
    
    let matBuf = Scr.matrixToBuffer mergedMatrix Scr.solidPxl
    let menuBuf = Scr.createBufferFromStringMatrix menu
    let final = Scr.renderInBuffer matBuf menuBuf 5 5
    Scr.printScreen final

    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    cmd <- getChar
    hSetBuffering stdin LineBuffering

    case cmd of 'q' -> func matrix -- retorna sem adicionar nada
                'f' -> func $ Gol.mergeMatrix pattern matrix row col -- posiciona
                'w' -> locatePatternRec func matrix pattern (row-1) col -- move para a cima
                's' -> locatePatternRec func matrix pattern (row+1) col -- move para a baixo
                'a' -> locatePatternRec func matrix pattern row (col-1) -- move para esquerda
                'd' -> locatePatternRec func matrix pattern row (col+1) -- move para direita
                'l' -> locatePatternRec func matrix (Gol.rotateMatrixLeft pattern) row col -- rotaciona a esquerda
                'r' -> locatePatternRec func matrix (Gol.rotateMatrixRight pattern) row col -- rotaciona a direita
                c -> locatePatternRec func matrix pattern row col

-- recebe uma funcao de callback que recebe uma matrix
-- e recebe a matrix e o padrao a ser posicionado
locatePattern :: ([[Int]] -> IO()) -> [[Int]] -> [[Int]] -> IO()
locatePattern func matrix pattern = locatePatternRec func matrix pattern 10 10
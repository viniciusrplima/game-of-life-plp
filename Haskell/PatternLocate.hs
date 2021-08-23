module PatternLocate where

import qualified Gol
import qualified Screen as Scr
import System.IO
import qualified System.Win32.FileMapping as Scr
import Text.XHtml.Transitional (content)



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
    let mergedMatrix = mergeMatrix2 pattern matrix row col
    
    let matBuf = matrixToBuffer2 mergedMatrix Scr.solidPxl
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


matrixToBuffer2 :: [[Int]] -> [Char] -> [[Scr.IPixel]]
matrixToBuffer2 [] _ = []
matrixToBuffer2 (row:matrix) content = matrixRowToBufferRow2 row content : matrixToBuffer2 matrix content

matrixRowToBufferRow2 :: [Int] -> [Char] -> [Scr.IPixel]
matrixRowToBufferRow2 [] _ = []
matrixRowToBufferRow2 (cell:row) content = createPixelFromGolCell2 cell content : matrixRowToBufferRow2 row content

createPixelFromGolCell2 :: Int -> [Char] -> Scr.IPixel
createPixelFromGolCell2 cell content
    | cell == 0 = Scr.Pixel (replicate (length content) ' ')
    | cell == 2 = Scr.Pixel content
    | cell == 1 = Scr.Pixel Scr.shadowPxl 


mergeMatrix2 :: [[Int]] -> [[Int]] -> Int -> Int -> [[Int]]
mergeMatrix2 _ [] _ _ = []
mergeMatrix2 [] target _ _ = target
mergeMatrix2 (srow:source) (trow:target) 0 col = mergeMatrixRow2 srow trow col : mergeMatrix2 source target 0 col
mergeMatrix2 source (trow:target) row col = trow : mergeMatrix2 source target (pred row) col

mergeMatrixRow2 :: [Int] -> [Int] -> Int -> [Int]
mergeMatrixRow2 _ [] _ = []
mergeMatrixRow2 [] targetRow _ = targetRow
mergeMatrixRow2 (scell:sourceRow) (tcell:targetRow) 0 = mergeCell2 scell tcell : mergeMatrixRow2 sourceRow targetRow 0
mergeMatrixRow2 sourceRow (tcell:targetRow) col = tcell : mergeMatrixRow2 sourceRow targetRow (pred col)



mergeCell2 :: Int -> Int -> Int
mergeCell2 0 0 = 0
mergeCell2 1 0 = 2
mergeCell2 0 1 = 1
mergeCell2 1 1 = 2
mergeCell2 a b = 0
    


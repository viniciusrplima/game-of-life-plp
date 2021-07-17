
import Text.Printf
import System.IO
import Control.Concurrent
import qualified Screen as Screen

-- matriz inicial do sistema
initialMatrix :: [String]
initialMatrix = [
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000000000000000000000000000000000000000000000000000000",
  "000100000000001000000001000000001000001000001000001000",
  "000110000000001100000001100000001100001100001100001100",
  "001010000000010100000010100000010100010100010100010100",
  "000000000000000000000000000000000000000000000000000000"]

deadCellChar = "  "
liveCellChar = "██"
surfaceCellChar = "░░"

deadCell = '0'
liveCell = '1'
surfaceCell = '2'

-- converte uma celula da matriz em uma String
convertToCell :: Char -> [Char]
convertToCell '1' = liveCellChar
convertToCell '2' = surfaceCellChar
convertToCell x = deadCellChar

------------------------------------------------------------------------
    --  Print Utils
    -------------------------------------------------------------------

createStrRow :: Int -> [Char] -> [Char]
createStrRow 0 c = ""
createStrRow w c = c ++ createStrRow (pred w) c

createStrMatrix :: Int -> Int -> [Char] -> [[Char]]
createStrMatrix w 0 c = []
createStrMatrix w h c = (createStrRow w c) : (createStrMatrix w (pred h) c)

termScale = 2

initialStrMatrix :: [[Char]]
initialStrMatrix = createStrMatrix (length (initialMatrix!!0)) (length initialMatrix) "  "

toStrCell :: Char -> [Char] -> [Char]
toStrCell '1' c = c
toStrCell x c = deadCellChar

printIntoStrRow :: [Char] -> [Char] -> [Char] -> [Char]
printIntoStrRow [] [] c = ""
printIntoStrRow (first:cellRow) line c = do
    let symbol = take termScale line
    if first == deadCell
       then symbol ++ printIntoStrRow cellRow (drop termScale line) c
       else (toStrCell first c) ++ printIntoStrRow cellRow (drop termScale line) c

printIntoStrMatrix :: [[Char]] -> [[Char]] -> [Char] -> [[Char]]
printIntoStrMatrix [] targetMap c = []
printIntoStrMatrix cellMap [] c = []
printIntoStrMatrix (first:cellMap) (line:targetMap) c = do
    (printIntoStrRow first line c) : printIntoStrMatrix cellMap targetMap c

concatenateMatrix :: [[Char]] -> [Char]
concatenateMatrix [] = ""
concatenateMatrix (row:matrix) = row ++ "\n" ++ concatenateMatrix matrix

printStrMatrix :: [[Char]] -> IO()
printStrMatrix matrix = putStrLn (Screen.colorizeString (concatenateMatrix matrix) "blue")

------------------------------------------------------------------------
    --------------------------------------------------------------------

------------------------------------------------------------------------
    --  Cell Map Matrix Utils
    --------------------------------------------------------------------

rowUnion :: [Char] -> [Char] -> [Char]
rowUnion rowA "" = ""
rowUnion "" rowB = ""
rowUnion (cellA:rowA) (cellB:rowB) = do
    if (cellA == '1' || cellB == '1')
       then '1' : rowUnion rowA rowB
       else '0' : rowUnion rowA rowB

matrixUnion :: [[Char]] -> [[Char]] -> [[Char]]
matrixUnion [] matB = []
matrixUnion matA [] = []
matrixUnion (rowA:matA) (rowB:matB) = (rowUnion rowA rowB) : (matrixUnion matA matB)


--------------------------------------------------------------------------
    ----------------------------------------------------------------------

-- converte um array em uma String
arrayToStr :: [Char] -> [Char]
arrayToStr [] = ""
arrayToStr (cell:rest) = convertToCell cell ++ arrayToStr rest

-- converte matriz em uma String
matrixToStr :: [[Char]] -> [Char]
matrixToStr [] = ""
matrixToStr (row:rest) = arrayToStr row ++ "\n" ++ matrixToStr rest

-- imprime uma matrix na tela
printMatrix :: [[Char]] -> IO ()
printMatrix matrix = putStrLn(matrixToStr matrix)

-- verifica se a posicao eh valida
isValidPosition :: Foldable t => [t a] -> Int -> Int -> Bool
isValidPosition matrix row col = do
  if row >= 0 && row < length matrix && col >= 0 && col < length (matrix!!0)
     then True
     else False

-- conta se a celula esta viva ou morte
-- se estiver viva retorna 1
-- se estiver morta ou esta for uma posicao invalida retorna 0
countLive :: Num p => [[Char]] -> Int -> Int -> p
countLive matrix row col = do
    let rowNorm = (row + length matrix) `mod` (length matrix)
    let colNorm = (col + length (matrix!!0)) `mod` (length (matrix!!0))
    if ((matrix!!rowNorm)!!colNorm == liveCell) 
       then 1 
       else 0


-- conta o numero total de vizinhos de uma celula
countNeighbors :: Num a => [[Char]] -> Int -> Int -> a
countNeighbors matrix row col = 
  countLive matrix (row-1) (col) +
  countLive matrix (row-1) (col-1) +
  countLive matrix (row-1) (col+1) +
  countLive matrix (row) (col-1) +
  countLive matrix (row) (col+1) +
  countLive matrix (row+1) (col) +
  countLive matrix (row+1) (col-1) +
  countLive matrix (row+1) (col+1)

-- calcula o proximo estado de uma celula
calculateNextCellState :: [[Char]] -> Int -> Int -> Char
calculateNextCellState matrix row col = do
  let neighbors = countNeighbors matrix row col
  let currentState = (matrix!!row)!!col
  if currentState == liveCell && (neighbors < 2 || neighbors > 3)
     then deadCell
     else if currentState == deadCell && neighbors == 3
     then liveCell
     else currentState

-- atualiza uma linha e retorna seu proximo estado
updateRowRecursive :: [[Char]] -> Int -> Int -> [Char]
updateRowRecursive matrix row col = do
  if isValidPosition matrix row col
     then calculateNextCellState matrix row col : updateRowRecursive matrix row (succ col)
     else []

-- funcao recursiva para atualizar matriz
updateMatrixRecursive :: [[Char]] -> Int -> [[Char]]
updateMatrixRecursive matrix row = do
  if row < length matrix
     then do
       let newRow = updateRowRecursive matrix row 0
       newRow : updateMatrixRecursive matrix (succ row)
     else []

-- atualiza matriz e retorna seu proximo estado
updateMatrix :: [[Char]] -> [[Char]]
updateMatrix matrix = updateMatrixRecursive matrix 0

-- laco principal do programa
mainLoop :: [[Char]] -> [[Char]] -> Integer -> IO()
mainLoop currentMatrix previousMatrix generation = do

  -- print screen
  printf "Generation %d\n" generation
  let surfaceMatrix = printIntoStrMatrix previousMatrix initialStrMatrix surfaceCellChar
  let finalMatrix = printIntoStrMatrix currentMatrix surfaceMatrix liveCellChar

  hSetBuffering stdout (BlockBuffering Nothing)
  printStrMatrix finalMatrix
  hSetBuffering stdout LineBuffering

  -- wait until press enter
  -- hSetBuffering stdin NoBuffering
  --getChar
  --hSetBuffering stdin LineBuffering

  threadDelay 30000

  -- chamada recursiva
  mainLoop (updateMatrix currentMatrix) (matrixUnion currentMatrix previousMatrix) (succ generation)

main :: IO()
main = mainLoop initialMatrix initialMatrix 1


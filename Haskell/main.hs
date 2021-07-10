
import Text.Printf

-- matriz inicial do sistema
initialMatrix :: [String]
initialMatrix = [
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000001010100000000",
  "00000010101010000000",
  "00000001010100000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000",
  "00000000000000000000"]

-- representacao das celulas em String
-- repare que tem dois caracteres cada para ficar melhor na tela
deadCellChar = "  "
liveCellChar = "██"

-- os valores possiveis da celula na matriz
deadCell = '0'
liveCell = '1'

-- converte uma celula da matriz em uma String
convertToCell :: Char -> [Char]
convertToCell '1' = liveCellChar -- se 1 retorna liveCell
convertToCell x = deadCellChar   -- senao retorna deadCell

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
  if isValidPosition matrix row col && (matrix!!row)!!col == liveCell
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
mainLoop :: [String] -> Integer -> IO()
mainLoop previousMatrix generation = do

  -- imprime a tela
  printf "Generation %d" generation
  printMatrix previousMatrix

  -- espera a tecla enter ser apertada
  getLine

  -- chamada recursiva para entrar em loop
  mainLoop (updateMatrix previousMatrix) (succ generation)

main :: IO()
main = mainLoop initialMatrix 1


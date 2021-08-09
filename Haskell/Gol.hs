-- nucleo das regras do game of life
module Gol where

-- ****************************
--  MATRIX
-- ****************************

liveCell :: Int
liveCell = 1

deadCell :: Int
deadCell = 0

-- cria matriz vazia
createEmptyMatrix :: Int -> Int -> [[Int]]
createEmptyMatrix x y = replicate y (replicate x 0)

-- verifica se a posicao eh valida
isValidPosition :: [[Int]] -> Int -> Int -> Bool
isValidPosition matrix row col = do
  if row >= 0 && row < length matrix && col >= 0 && col < length (matrix!!0)
     then True
     else False

-- conta se a celula esta viva ou morta
-- se estiver viva retorna 1
-- se estiver morta ou esta for uma posicao invalida retorna 0
countLive :: [[Int]] -> Int -> Int -> Int
countLive matrix row col = do
    let rowNorm = (row + length matrix) `mod` (length matrix)
    let colNorm = (col + length (matrix!!0)) `mod` (length (matrix!!0))
    if ((matrix!!rowNorm)!!colNorm == liveCell) 
       then 1
       else 0

-- conta o numero total de vizinhos de uma celula
countNeighbors :: [[Int]] -> Int -> Int -> Int
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
calculateNextCellState :: [[Int]] -> Int -> Int -> Int
calculateNextCellState matrix row col = do
  let neighbors = countNeighbors matrix row col
  let currentState = (matrix!!row)!!col
  if currentState == liveCell && (neighbors < 2 || neighbors > 3)
     then deadCell
     else if currentState == deadCell && neighbors == 3
     then liveCell
     else currentState

-- atualiza uma linha e retorna seu proximo estado
updateRowRecursive :: [[Int]] -> Int -> Int -> [Int]
updateRowRecursive matrix row col = do
  if isValidPosition matrix row col
     then calculateNextCellState matrix row col : updateRowRecursive matrix row (succ col)
     else []

-- funcao recursiva para atualizar matriz
updateMatrixRecursive :: [[Int]] -> Int -> [[Int]]
updateMatrixRecursive matrix row = do
  if row < length matrix
     then do
       let newRow = updateRowRecursive matrix row 0
       newRow : updateMatrixRecursive matrix (succ row)
     else []

-- atualiza matriz e retorna seu proximo estado
advanceMatrix :: [[Int]] -> [[Int]]
advanceMatrix matrix = updateMatrixRecursive matrix 0


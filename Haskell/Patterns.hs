-- reune os padroes do jogo
module Patterns where

import qualified Screen
import qualified Gol

glider :: [[Int]]
glider = [
    [1,0,1], 
    [0,1,1], 
    [0,1,0]]

dart :: [[Int]]
dart = [
    [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0], 
    [0,0,0,0,0,0,1,0,1,0,0,0,0,0,0], 
    [0,0,0,0,0,1,0,0,0,1,0,0,0,0,0], 
    [0,0,0,0,0,0,1,1,1,0,0,0,0,0,0], 
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 
    [0,0,0,0,1,1,0,0,0,1,1,0,0,0,0], 
    [0,0,1,0,0,0,1,0,1,0,0,0,1,0,0], 
    [0,1,1,0,0,0,1,0,1,0,0,0,1,1,0], 
    [1,0,0,0,0,0,1,0,1,0,0,0,0,0,1], 
    [0,1,0,1,1,0,1,0,1,0,1,1,0,1,0]]

_64P2H1V0 :: [[Int]]
_64P2H1V0 = [
    [0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0], 
    [0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0],
    [0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0],
    [0,0,1,0,1,0,1,1,0,1,1,0,0,0,1,1,1,0,0,0,1,1,0,1,1,0,1,0,1,0,0],
    [0,1,1,0,1,0,0,0,0,1,0,1,1,0,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,1,0],
    [1,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,1,0,0,0,0,1],
    [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
    [1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1]]

patterns :: [([Char], [[Int]])]
patterns = [
    ("Glider", glider), 
    ("Dart", dart), 
    ("64P2H1V0", _64P2H1V0)]


-- ****************************
--  TESTS
-- ****************************

printPattern :: [[Int]] -> IO()
printPattern pattern = Screen.printScreen $ Screen.matrixToBuffer pattern "██" "white"

printPatternSequence :: [[Int]] -> Int -> IO()
printPatternSequence _ 0 = putStrLn ""
printPatternSequence pattern seq = do
    let width = length (pattern!!0)
    let height = length pattern
    let matrix = Gol.createEmptyMatrix (width+2) (height+2)

    let matrixWithPattern = Gol.mergeMatrix pattern matrix 1 1
    let nextPatternSequence = Gol.advanceMatrix matrixWithPattern

    printPattern matrixWithPattern

    printPatternSequence nextPatternSequence (seq-1)

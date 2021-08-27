
module PatternsofRules where

import qualified Screen
import qualified Gol


zero :: [[Int]]
zero = [[0,0,0]]

first :: [[Int]]
first = [[0,0,0,0,0],
         [0,0,0,0,0],
         [0,0,1,0,0],
         [0,0,0,0,0],
         [0,0,0,0,0]]

second :: [[Int]]
second =[[0,0,0,0,0],
         [0,1,0,1,0],
         [0,0,1,0,0],
         [0,1,0,1,0],
         [0,0,0,0,0]]
      
third :: [[Int]]
third = [[0,0,0,0,0],
         [0,0,0,1,0],
         [0,0,1,0,0],
         [0,0,0,1,0],
         [0,0,0,0,0]]

fourth:: [[Int]]
fourth = [[0,0,0,0,0],
          [0,1,0,0,0],
          [0,0,1,0,0],
          [0,0,0,1,0],
          [0,0,0,0,0]]

patterns :: [[[Int]]]
patterns = [zero,
            first,
            second,
            third,
            fourth]
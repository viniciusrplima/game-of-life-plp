-- reune os padroes do jogo
module Patterns where

import qualified Screen
import qualified Gol
import Data.List

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

brain :: [[Int]]
brain = [[0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0],
         [0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0],
         [1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1],                      
         [1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1],                     
         [0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0],                     
         [0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0],                    
         [0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0],                    
         [0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0],                   
         [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0],                   
         [1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1],                   
         [0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0]]

turtle :: [[Int]]
turtle =  [[0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
           [0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0], 
           [0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0],
           [0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0],
           [0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0], 
           [1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0], 
           [1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0], 
           [0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0], 
           [0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0], 
           [0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0], 
           [0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0], 
           [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

sidecar:: [[Int]]
sidecar =  [[0, 1, 0, 0, 0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 0, 1, 0, 0],
            [1, 1, 1, 1, 1, 0, 1, 0, 0], 
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 1, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0, 1, 0], 
            [0, 1, 0, 0, 0, 0, 0, 0, 0], 
            [0, 1, 0, 0, 0, 0, 0, 1, 0], 
            [0, 1, 1, 1, 1, 1, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0], 
            [0, 0, 0, 0, 0, 0, 0, 0, 0]]

swan:: [[Int]]
swan =[[1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
       [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
       [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1], 
       [0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0],
       [0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0],
       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0], 
       [0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0], 
       [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

orion:: [[Int]]
orion = [[0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
         [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
         [1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
         [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0], 
         [0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1],
         [0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1], 
         [0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0], 
         [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0],
         [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

crab :: [[Int]]
crab = [[0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0], 
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0], 
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0], 
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0], 
        [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0], 
        [1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0], 
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
        [0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0]]

wing :: [[Int]]
wing = [[0, 1, 1, 0], 
        [1, 0, 0, 1], 
        [0, 1, 0, 1],
        [0, 0, 1, 1]]

hammerhead:: [[Int]]
hammerhead =[[1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
             [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
             [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0],
             [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0],
             [0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0],
             [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0], 
             [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
             [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0],
             [0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0],
             [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0],
             [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0],
             [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
             [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

lightweight_Spaceship :: [[Int]]
lightweight_Spaceship =[[0, 1, 0, 0, 1, 0], 
                       [1, 0, 0, 0, 0, 0], 
                       [1, 0, 0, 0, 1, 0],
                       [1, 1, 1, 1, 0, 0]]

loafer :: [[Int]]
loafer = [[0, 1, 0, 0, 1, 1, 0, 0, 0, 0],
          [1, 0, 0, 0, 1, 1, 1, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 1, 0, 0],
          [0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
          [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 1, 0, 0, 0, 1, 0, 1], 
          [0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0, 1, 1, 0, 1, 0], 
          [0, 0, 0, 0, 0, 1, 0, 0, 1, 0],
          [0, 0, 0, 0, 0, 0, 1, 1, 0, 0]]

copperhead :: [[Int]]
copperhead = [[0, 1, 1, 0, 0, 1, 1, 0], 
              [0, 0, 0, 1, 1, 0, 0, 0], 
              [0, 0, 0, 1, 1, 0, 0, 0], 
              [1, 0, 1, 0, 0, 1, 0, 1], 
              [1, 0, 0, 0, 0, 0, 0, 1], 
              [0, 0, 0, 0, 0, 0, 0, 0], 
              [1, 0, 0, 0, 0, 0, 0, 1],
              [0, 1, 1, 0, 0, 1, 1, 0],
              [0, 0, 1, 1, 1, 1, 0, 0],
              [0, 0, 0, 0, 0, 0, 0, 0],
              [0, 0, 0, 1, 1, 0, 0, 0],
              [0, 0, 0, 1, 1, 0, 0, 0]]

b_heptomino:: [[Int]]
b_heptomino = [[1, 0, 1, 1, 0],
               [1, 1, 1, 0, 0],
               [0, 1, 0, 0, 0],
               [0, 0, 0, 0, 0]]

pi_heptomino :: [[Int]]
pi_heptomino= [[0, 1, 1, 1, 0], 
               [0, 1, 0, 1, 0],
               [0, 1, 0, 1, 0],
               [0, 0, 0, 0, 0], 
               [0, 0, 0, 0, 0]]

middleweight_spaceship :: [[Int]]
middleweight_spaceship = [[0, 0, 0, 1, 0, 0, 0],
                          [0, 1, 0, 0, 0, 1, 0],  
                          [1, 0, 0, 0, 0, 0, 0],
                          [1, 0, 0, 0, 0, 1, 0],
                          [1, 1, 1, 1, 1, 0, 0]]



heavyweight_Spaceship :: [[Int]]
(heavyweight_Spaceship) = [[0, 0, 0, 1, 1, 0, 0, 0],
                         [0, 1, 0, 0, 0, 0, 1, 0], 
                         [1, 0, 0, 0, 0, 0, 0, 0], 
                         [1, 0, 0, 0, 0, 0, 1, 0], 
                         [1, 1, 1, 1, 1, 1, 0, 0]]

r_pentomino :: [[Int]]
r_pentomino = [[0, 1, 1, 0],
               [1, 1, 0, 0],
               [0, 1, 0, 0],
               [0, 0, 0, 0]]


puffer1 :: [[Int]]
puffer1 = [[0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0],
           [1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1], 
           [0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0], 
           [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], 
           [0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0], 
           [0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0], 
           [0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0], 
           [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

puffer2 :: [[Int]]
puffer2 = [[0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], 
           [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1], 
           [0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1], 
           [0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
           [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
           [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

pufferfish :: [[Int]]
pufferfish = [[0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], 
              [0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
              [0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0], 
              [0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
              [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
              [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0], 
              [0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0], 
              [1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0], 
              [1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0], 
              [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0], 
              [0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0], 
              [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
              [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

gliderFlower :: [[Int]]
gliderFlower = [
    [0,1,0,0,0,1,1,0],
    [1,1,0,0,0,0,1,1],
    [1,0,1,0,0,1,0,0],
    [0,0,0,1,1,0,0,0],
    [0,0,0,1,1,0,0,0],
    [0,0,1,0,0,1,0,1],
    [1,1,0,0,0,0,1,1],
    [0,1,1,0,0,0,1,0]]

patterns :: [([Char], [[Int]])]
patterns = sort [
    ("Glider", glider),
    ("Dart", dart),
    ("64P2H1V0",_64P2H1V0),
    ("Brain", brain),
    ("Turtle", turtle),
    ("Sidecar", sidecar),
    ("Swan", swan),
    ("Orion", orion),
    ("Crab", crab),
    ("Wing", wing),
    ("Hammerhead", hammerhead),
    ("Lightweight Spaceship", lightweight_Spaceship),
    ("Loafer", loafer),
    ("Copperhead ", copperhead),
    ("B-heptomino", b_heptomino),
    ("Pi-heptomino", pi_heptomino),
    ("Middleweight Spaceship", middleweight_spaceship),
    ("Heavyweight Spaceship", heavyweight_Spaceship),
    ("R-pentomino", r_pentomino),
    ("Puffer 1", puffer1),
    ("Puffer 2", puffer2),
    ("Pufferfish", pufferfish),
    ("Glider Flower", gliderFlower)]

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

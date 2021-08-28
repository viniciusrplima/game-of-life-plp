module PatternsofRules where

import qualified Screen as Scr
import qualified MatrixView as Mv
import qualified PatternSelect as Ps
import qualified Terminal
import qualified Patterns as Ptn
import qualified Gol as Gol
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent



first :: ([[Int]],[[Int]])
first = ([[1]],[[0]])

second :: ([[Int]],[[Int]])
second = ([[0,0,0,0,0],
          [0,1,0,1,0],
          [0,0,1,0,0],
          [0,1,0,1,0],
          [0,0,0,0,0]],
          [[0,0,0,0,0],
          [0,0,1,0,0],
          [0,1,0,1,0],
          [0,0,1,0,0],
          [0,0,0,0,0]])
        
      
third :: ([[Int]],[[Int]])
third = ([[0,0,0,0,0],
         [0,0,0,1,0],
         [0,0,1,0,0],
         [0,0,0,1,0],
         [0,0,0,0,0]],
         [[0,0,0,0,0],
         [0,0,0,0,0],
         [0,0,1,1,0],
         [0,0,0,0,0],
         [0,0,0,0,0]])


fourth :: ([[Int]],[[Int]])
fourth = ([[0,0,0,0,0],
          [0,1,0,0,0],
          [0,0,1,0,0],
          [0,0,0,1,0],
          [0,0,0,0,0]],
          [[0,0,0,0,0],
          [0,0,0,0,0],
          [0,0,1,0,0],
          [0,0,0,0,0],
          [0,0,0,0,0]])

firstExplanation :: [[Char]]
firstExplanation = ["Note que a célula da primeira geração deixa de estar viva na segunda, cumprindo com a regra."]

secondExplanation :: [[Char]]
secondExplanation = ["Note que a célula que se encontra no meio do padrão na primeira geração, deixa de estar viva na segunda, cumprindo com a regra."]

thirdExplanation :: [[Char]]
thirdExplanation = ["Note que a célula não-viva que se encontra no meio das trẽs vivas na primeira geração, torna-se uma célula viva, cumprindo com a regra."]

fourthExplanation :: [[Char]]
fourthExplanation = ["Note que a célula viva que se encontra no meio do padrão da primeira geração, continua na segunda, cumprindo com a regra."]

tag :: ([[Char]],[[Char]])
tag = (["Primeira Geração:"],
       ["Segunda Geração:"])


commandsTable :: [[Char]]
commandsTable = [
    " q - Voltar"]


printRuleOne :: IO()
printRuleOne = do

    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    let matrixBuf = Scr.matrixToBuffer (fst first) Scr.solidPxl
    let sndMatrixBuf = Scr.matrixToBuffer (snd first) Scr.solidPxl
    let explanationBuf = Scr.createBufferFromStringMatrix firstExplanation
    let fstText = Scr.createBufferFromStringMatrix (fst tag)
    let sndText = Scr.createBufferFromStringMatrix (snd tag)
    
    let tmp1 = Scr.renderInBuffer initialBuffer tableBuf 1 3
    let tmp2 = Scr.renderInBuffer tmp1 matrixBuf 30 10
    let tmp3 = Scr.renderInBuffer tmp2 explanationBuf 10 30
    let tmp4 = Scr.renderInBuffer tmp3 sndMatrixBuf 30 20
    let tmp5 = Scr.renderInBuffer tmp4 fstText 5 10
    let tmp6 = Scr.renderInBuffer tmp5 sndText 5 20
    
    Scr.printScreen tmp6 

    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

      
    case command of 'q' -> putStrLn " "
                    cmd -> printRuleOne
    

printRuleTwo :: IO()
printRuleTwo = do

    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    let matrixBuf = Scr.matrixToBuffer (fst second) Scr.solidPxl
    let sndMatrixBuf = Scr.matrixToBuffer (snd second) Scr.solidPxl
    let explanationBuf = Scr.createBufferFromStringMatrix secondExplanation
    let fstText = Scr.createBufferFromStringMatrix (fst tag)
    let sndText = Scr.createBufferFromStringMatrix (snd tag)
    
    let tmp1 = Scr.renderInBuffer initialBuffer tableBuf 1 3
    let tmp2 = Scr.renderInBuffer tmp1 matrixBuf 30 10
    let tmp3 = Scr.renderInBuffer tmp2 explanationBuf 4 30
    let tmp4 = Scr.renderInBuffer tmp3 sndMatrixBuf 30 20
    let tmp5 = Scr.renderInBuffer tmp4 fstText 5 10
    let tmp6 = Scr.renderInBuffer tmp5 sndText 5 20
    
    Scr.printScreen tmp6 


    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    case command of 'q' -> putStrLn " "
                    cmd -> printRuleTwo

printRuleThree :: IO()
printRuleThree = do

    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    let matrixBuf = Scr.matrixToBuffer (fst third) Scr.solidPxl
    let sndMatrixBuf = Scr.matrixToBuffer (snd third) Scr.solidPxl
    let explanationBuf = Scr.createBufferFromStringMatrix thirdExplanation
    let fstText = Scr.createBufferFromStringMatrix (fst tag)
    let sndText = Scr.createBufferFromStringMatrix (snd tag)
    
    let tmp1 = Scr.renderInBuffer initialBuffer tableBuf 1 3
    let tmp2 = Scr.renderInBuffer tmp1 matrixBuf 30 10
    let tmp3 = Scr.renderInBuffer tmp2 explanationBuf 2 30
    let tmp4 = Scr.renderInBuffer tmp3 sndMatrixBuf 30 20
    let tmp5 = Scr.renderInBuffer tmp4 fstText 5 10
    let tmp6 = Scr.renderInBuffer tmp5 sndText 5 20
    
    Scr.printScreen tmp6 

    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    case command of 'q' -> putStrLn " "
                    cmd -> printRuleThree

printRuleFour :: IO()
printRuleFour = do

    let initialBuffer = Scr.createScreenBuffer Scr.width Scr.height Scr.emptyPxl
    let tableBuf = Scr.createBufferFromStringMatrix commandsTable
    let matrixBuf = Scr.matrixToBuffer (fst fourth) Scr.solidPxl
    let sndMatrixBuf = Scr.matrixToBuffer (snd fourth) Scr.solidPxl
    let explanationBuf = Scr.createBufferFromStringMatrix fourthExplanation
    let fstText = Scr.createBufferFromStringMatrix (fst tag)
    let sndText = Scr.createBufferFromStringMatrix (snd tag)
    
    let tmp1 = Scr.renderInBuffer initialBuffer tableBuf 1 3
    let tmp2 = Scr.renderInBuffer tmp1 matrixBuf 30 10
    let tmp3 = Scr.renderInBuffer tmp2 explanationBuf 5 30
    let tmp4 = Scr.renderInBuffer tmp3 sndMatrixBuf 30 20
    let tmp5 = Scr.renderInBuffer tmp4 fstText 5 10
    let tmp6 = Scr.renderInBuffer tmp5 sndText 5 20
    
    Scr.printScreen tmp6 

    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    case command of 'q' -> putStrLn " "
                    cmd -> printRuleFour


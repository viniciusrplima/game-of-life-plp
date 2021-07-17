module Screen where

import Text.Printf
import System.IO

-- cria uma matrix de strings que serve como buffer para
-- imprimir na tela
createScreenBuffer :: Integer -> Integer -> Integer -> Char -> [[Char]]
createScreenBuffer _ 0 _ _ = []
createScreenBuffer width height scale c = do 
    createScreenRowBuf (width * scale) c : createScreenBuffer width (pred height) scale c

-- cria uma linha do buffer
createScreenRowBuf :: Integer -> Char -> [Char]
createScreenRowBuf 0 _ = ""
createScreenRowBuf width c = c : createScreenRowBuf (pred width) c

-- renderiza um buffer na tela utilizando
-- buffer na saída do terminal
printScreen :: [[Char]] -> IO()
printScreen buffer = do
    hSetBuffering stdout (BlockBuffering Nothing)
    printScreenStd buffer
    hSetBuffering stdout LineBuffering

-- renderiza um buffer na tela
printScreenStd :: [[Char]] -> IO()
printScreenStd [] = putStrLn ""
printScreenStd (row:buffer) = do 
    putStrLn row
    printScreen buffer

-- retorna uma cor
getColor :: [Char] -> [Char]
getColor "black"    = "30"
getColor "red"      = "31"
getColor "green"    = "32"
getColor "yellow"   = "33"
getColor "blue"     = "34"
getColor "purple"   = "35"
getColor "leaf"     = "36"

-- colore uma string
colorizeString :: [Char] -> [Char] -> [Char]
colorizeString text color = ("\x1b[" ++ (getColor color) ++ "m " ++ text ++ "\x1b[0m")

-- colore um buffer inteiro
colorizeBuffer :: [[Char]] -> [Char] -> [[Char]]
colorizeBuffer [] color = []
colorizeBuffer (row:buffer) color = colorizeString row color : colorizeBuffer buffer color

-- imprime buffer no buffer
renderInBuffer :: [[Char]] -> [[Char]] -> Int -> Int -> [[Char]]
renderInBuffer buffer source x y
    | length buffer == 0    = buffer
    | length source == 0    = buffer
    | y <= 0                = printInString bufferFirst sourceFirst x : renderInBuffer bufferTail sourceTail x y
    | otherwise             = bufferFirst : renderInBuffer bufferTail source x (pred y)
    where bufferFirst = head buffer
          bufferTail = tail buffer 
          sourceFirst = head source
          sourceTail = tail source

-- imprime string em outra string
printInString :: [Char] -> [Char] -> Int -> [Char]
printInString target source i 
    | source == ""      = target
    | i >= length target= target
    | i <= 0            = sourceFirst : printInString targetTail sourceTail 0
    | otherwise         = targetFirst : printInString targetTail source (pred i) 
    where targetFirst = head target
          targetTail = tail target
          sourceFirst = head source
          sourceTail = tail source


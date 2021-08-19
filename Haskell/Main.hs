
import qualified Screen as Screen
import qualified MatrixView as MatrixView
import qualified Terminal
import System.IO
import System.IO.Unsafe (unsafeDupablePerformIO)
import System.Exit
import Control.Concurrent
import qualified Gol

termSize = unsafeDupablePerformIO Terminal.getTermSize
termHeight = fst termSize
termWidth = snd termSize

pixelWidth = 2

emptyPxl = replicate pixelWidth ' '
shadowPxl = replicate pixelWidth '░'
solidPxl = replicate pixelWidth '█'

initialBuffer = Screen.createScreenBuffer (termWidth `div` pixelWidth) termHeight emptyPxl

menu :: [[Char]]
menu = [
    "██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██", 
    "  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ", 
    "                                                  ",
    "               ██████ ██████ █                    ", 
    "               █      █    █ █                    ", 
    "               █    █ █    █ █                    ", 
    "               ██████ ██████ ██████               ", 
    "                                                  ", 
    "██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██", 
    "  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ", 
    "                                                  ", 
    "                                                  ", 
    "                     Start    ", 
    "                     Records  ", 
    "                     Quit     ", 
    "                                                  ", 
    "                                                  "]

   


commandsTable :: [[Char]]
commandsTable = [
    "                       ", 
    " s / w - mover cursor  ", 
    " f - selecionar        ", 
    " ctrl+c - sair do jogo ", 
    "                       "]


logo :: [[Int]]
logo = [
    [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
    [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,1,1,1,0,1,1,1,0,1,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,1,1,1,0,1,1,1,0,1,1,1,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
    [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]]

--Cores
palette :: [[Char]]
palette = ["blue","white","red","green","yellow","purple","leaf"]

paletteBg :: [[Char]]
paletteBg = ["bg-blue","bg-leaf","bg-purple","bg-yellow","bg-green","bg-red","bg-white"]

--Cria a nimacao ao inicia
animation :: Int -> IO ()
animation value = do
    if value < 7
        then do
            let color = palette !! value
            let shadow1 = Screen.createScreenBufferColored 40 25 shadowPxl color
            let rect1 = Screen.createScreenBufferColored 40 25 solidPxl color

            let time1 = Screen.renderInBuffer initialBuffer shadow1 15 5
            let time2 = Screen.renderInBuffer time1 rect1 16 6
            let time3 = Screen.renderInBuffer time2 (Screen.matrixToBuffer logo solidPxl (paletteBg !! value)) 23 10
            Screen.printScreen time3
            threadDelay 999999
            animation(value + 1)
        else MatrixView.printMatrixView termWidth termHeight


-- cria o menu e imprime ele na tela
printMenu :: [[Char]] -> IO()
printMenu menuTab = do
    let menuColor = "blue"
    let shadow = Screen.createScreenBufferColored 40 25 shadowPxl menuColor
    let rect = Screen.createScreenBufferColored 40 25 solidPxl menuColor
    let menuBuf = Screen.createBufferFromStringMatrix menuTab pixelWidth "bg-blue"
    let tableBuf = Screen.createBufferFromStringMatrix commandsTable pixelWidth "bg-red"

    let tmp1 = Screen.renderInBuffer initialBuffer shadow 15 5
    let tmp2 = Screen.renderInBuffer tmp1 rect 16 6
    let tmp3 = Screen.renderInBuffer tmp2 menuBuf 23 10
    let tmp4 = Screen.renderInBuffer tmp3 tableBuf 1 3

    Screen.printScreen tmp4

-- cria o cursor que fica do lado das opcoes do menu
printArrow :: [[Char]] -> Int -> [[Char]]
printArrow [] _ = []
printArrow (row:rest) 0     = (row ++ "<<<") : rest
printArrow (row:rest) i     = row : printArrow rest (pred i)

mainLoop :: Int -> IO()
mainLoop index = do
    let maxIndex = 3
    let offset = 12

    printMenu $ printArrow menu (index + offset)
    
    -- pega um unico caracter da entrada
    hSetBuffering stdin NoBuffering
    command <- getChar
    hSetBuffering stdin LineBuffering

    -- recalcula posicao do cursor
    let newIndex = case command of 'w' -> ((pred index) + maxIndex) `mod` maxIndex
                                   's' -> ((succ index) + maxIndex) `mod` maxIndex
                                   cmd -> index

    if command == 'f' && index == 2 then exitSuccess   -- desistir da partida
    else if command == 'f' && index == 0 then animation 0 -- iniciar jogo
    else putStrLn ""       -- continua no menu

    mainLoop newIndex


main :: IO()
main = mainLoop 0

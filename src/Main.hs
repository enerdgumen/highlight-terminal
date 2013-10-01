import System.IO
import System.Environment
import Rule
import Highlight
import Terminal


--main = putStrLn $ encodeStyles [Background Red] ++ "mandi" ++ encodeStyles [Foreground Green] ++ " bello" ++ resetString ++ encodeStyles [Background Red] ++"ooook" ++ resetString

--import Text.Regex.TDFA
--main = print $ getAllMatches (":: ciao bello" =~ "::( ([a-z]+))+" :: AllMatches [] (Int, Int))

text = "testo di prova"

rules = [SimpleRule "di" [Background Red]]

main :: IO ()
main = putStrLn $ highlight rules text

{-
main :: IO ()
main = do
   fileNames <- getArgs
   contents <- readFile $ head fileNames
   interact $ highlight (read contents :: [PatternAndStyles])
-}
module Highlight where

import Text.Regex.TDFA
import Data.List(sort, sortBy, (\\))
import Data.Ord(comparing)
import Terminal
import Rule

data Directive = Start Styles | End Styles

type Insertion a = (Int, [a])

-- A comment
highlight :: [PatternAndStyles] -> String -> String
highlight rules line = insert line $ collapse $ apply rules line

{- Another
   comment -}
apply :: [PatternAndStyles] -> String -> [(Int, Directive)]
apply rules line = 
  do (pattern, styles) <- rules
     (start, len) <- getAllMatches (line =~ pattern :: AllMatches [] (Int, Int))
     [(start, Start styles), (start + len, End styles)]

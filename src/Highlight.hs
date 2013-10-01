module Highlight where

import Text.Regex.TDFA
import Data.List(sort, sortBy, (\\))
import Data.Ord(comparing)
import Terminal
import Rule

data Directive = Start Styles | End Styles

type Position = Int
type Insertion a = (Position, [a])

highlight :: Rules -> String -> String
highlight rules line = insert line 
                     $ mapInsertions 
                     $ collapseDirectives 
                     $ apply line rules

mapInsertions :: [(Position, Styles)] -> [(Position, String)]
mapInsertions xs = 
  do (p, s) <- xs
     return (p, encodeStyles s)

apply :: String -> Rules -> [(Position, Directive)]
apply line = concatMap $ applyRule line

applyRule :: String -> Rule -> [(Position, Directive)]
applyRule line (SimpleRule pattern styles) = 
  do (start, len) <- getAllMatches (line =~ pattern :: AllMatches [] (Int, Int))
     [(start, Start styles), (start + len, End styles)]
    
collapseDirectives :: [(Position, Directive)] -> [(Position, Styles)]
collapseDirectives = collapseDirectives' [] . sortBy (comparing fst)

collapseDirectives' :: Styles -> [(Position, Directive)] -> [(Position, Styles)]
collapseDirectives' _ [] = []
collapseDirectives' actualStyles ((pos, d):ds) = (pos, styles) : collapseDirectives' nextStyles ds
  where
    (styles, nextStyles) = collapseDirective d actualStyles
    
collapseDirective (Start styles) actualStyles = (styles, actualStyles ++ styles)
collapseDirective (End   styles) actualStyles = (Reset : nextStyles, nextStyles)
  where
    nextStyles = actualStyles \\ styles

insert :: Ord a => [a] -> [Insertion a] -> [a]
insert xs = foldr insert' xs . sort
  where
    insert' (n, ys) zs = let (xs', xs'') = splitAt n zs 
                         in xs' ++ ys ++ xs''

module Rule where

type Rules = [Rule]

data Rule = SimpleRule Pattern Styles
          | CompositeRule Pattern Rule

type PatternAndStyles = (String, Styles)

type Pattern = String

type Styles = [Style]

data Style = Bold | Italic | Underline | Blink | Visible | Invisible
           | Foreground Color 
           | Background Color
           | Swap
           | Reset
           deriving (Read, Show, Eq)

data Color = Black
           | Red
           | Green
           | Yellow
           | Blue
           | Magenta
           | Cyan
           | White
           deriving (Read, Show, Eq)
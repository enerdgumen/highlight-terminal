module Terminal where

import qualified System.Console.ANSI as ANSI
import Rule

encodeStyles :: [Style] -> String
encodeStyles = ANSI.setSGRCode . map ansiStyle

ansiStyle :: Style -> ANSI.SGR
ansiStyle style = case style of
    Bold             -> ANSI.SetConsoleIntensity ANSI.BoldIntensity
    Italic           -> ANSI.SetItalicized True
    Underline        -> ANSI.SetUnderlining ANSI.SingleUnderline
    Blink            -> ANSI.SetBlinkSpeed ANSI.SlowBlink
    Visible          -> ANSI.SetVisible True
    Invisible        -> ANSI.SetVisible False
    Foreground color -> ANSI.SetColor ANSI.Foreground ANSI.Vivid $ ansiColor color
    Background color -> ANSI.SetColor ANSI.Background ANSI.Vivid $ ansiColor color
    Swap             -> ANSI.SetSwapForegroundBackground True
    Reset            -> ANSI.Reset

ansiColor :: Color -> ANSI.Color
ansiColor color = case color of
    Black   -> ANSI.Black
    Red     -> ANSI.Red
    Green   -> ANSI.Green
    Yellow  -> ANSI.Yellow
    Blue    -> ANSI.Blue
    Magenta -> ANSI.Magenta
    Cyan    -> ANSI.Cyan
    White   -> ANSI.White

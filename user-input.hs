{-
User Input Example
Author: Mike K.

Usage: runhaskell user-input.hs
When prompted, enter a name and press enter.
-}
ain'tThisAWeirdFunction::String -> String
ain'tThisAWeirdFunction str = str ++ ", huh." -- string concatenation

main = do
  putStrLn "What's your name?"
  input <- getLine
  if null input
    then return() -- terminates the program when no input is given
    else putStrLn (ain'tThisAWeirdFunction input)

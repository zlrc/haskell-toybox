{-
A Simple Binary Code Translator
Author: Mike K.

Usage: runhaskell binary.hs inputfile.txt
"hello.txt" and "queen.txt" are sample input files that can be used with this program.
-}
import Data.Char -- to help us convert numbers to characters and vice-versa
import System.IO -- reading & writing from files
import System.Environment -- command line arguments


-- Recursively adds each a*b product in the list p and returns the sum
productSum::[(Int, Char)] -> Int
productSum p =
  if p == [] then 0 else do      -- do block lets us run "impure" code
  let { (x, y) =                 -- nested "let" statement so we can individually reference x and y
    let (a:_) = p in a }         -- pattern matches (grabs) the first tuple in the list [(a, 'b'), (c, 'd'), ...]
  (x * (digitToInt y)) + (productSum . tail $ p) -- multiplies x & y and adds to the total sum


{-
- Given a single binary character (e.g. 01101111), convert to that character's ascii equivelant
- zip creates a list of tuples ex: [(256, '0'), (128, '1'), ... (1, '0')]
- chr converts an integer into the respective character (e.g. 42 becomes '*')
- We get our special integer by running the productSum function above.
-}
decode::String -> Char
decode b = chr (productSum (zip [2^x | x <- [7,6..0]] b) )


{-
- Splits a binary string by whitespace and maps "decode" to each item in the
- resulting list. The result should be a list of chars that form our translation.
-}
translate::String -> String
translate binary = map decode . words $ binary


-- Prints out binary code translations from a given file
main = do                          -- "do" runs each line below (aka "impure" code)
  args <- getArgs                  -- get the command line arguments
  contents <- readFile (head args) -- reads the first argument; readFile closes files automatically
  putStrLn (translate contents)    -- take a guess

-- Using monads to do the above without the "do"
--main = getArgs >>= \args -> readFile(head args) >>= \contents -> putStrLn (translate contents)

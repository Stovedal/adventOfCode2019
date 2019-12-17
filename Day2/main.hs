import Data.Char  
import Data.List.Split

main = do  
    contents <- (splitOn "," getContents)
    putStr (map (=="3") contents)  
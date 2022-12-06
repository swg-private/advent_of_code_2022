module Main where

    import Data.Char (isNumber, isUpper)
    import Data.List (transpose)
    import Data.List.Split (chunksOf)

    type Move = (Int, Int, Int)

    -- Initial stack layout
    --            [J] [Z] [G]            
    --            [Z] [T] [S] [P] [R]    
    --[R]         [Q] [V] [B] [G] [J]    
    --[W] [W]     [N] [L] [V] [W] [C]    
    --[F] [Q]     [T] [G] [C] [T] [T] [W]
    --[H] [D] [W] [W] [H] [T] [R] [M] [B]
    --[T] [G] [T] [R] [B] [P] [B] [G] [G]
    --[S] [S] [B] [D] [F] [L] [Z] [N] [L]
    -- 1   2   3   4   5   6   7   8   9

    main :: IO ()
    main = do
        totalInput <- lines <$> readFile "input.txt"
        let stacks = getStacks . init $ takeWhile (/= "") totalInput
        let moves = getMoves . drop 1 $ dropWhile (/= "") totalInput
        -- Task 1
        print stacks

    getStacks :: [String] -> [[String]]
    getStacks l = 
        let
            dropWhitespace s = map (map (filter isUpper)) s
            dropEmptySpaces = map $ dropWhile (== "")
        in
            dropEmptySpaces . dropWhitespace . transpose $ map (chunksOf 4) l    

    getMoves :: [String] -> [Move]
    getMoves = map getMove

    getMove :: String -> Move
    getMove s =
        let
            getNumber 1 s = read . takeWhile isNumber $ dropWhile (not . isNumber) s :: Int
            getNumber n s = getNumber (n-1) $ dropWhile isNumber $ dropWhile (not . isNumber) s
        in
            (getNumber 1 s, getNumber 2 s, getNumber 3 s)


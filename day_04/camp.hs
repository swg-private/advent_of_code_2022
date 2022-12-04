module Main where

    import Data.List.Split (splitOneOf)

    type ClearingPatch = (Int, Int)
    type ElfPair = (ClearingPatch, ClearingPatch)

    main :: IO ()
    main = do
        elfPairs <- preProcessData . lines <$> readFile "input.txt"
        -- Task 1
        let result1 = task1 elfPairs
        putStrLn $ (show result1) ++ " pairs of elves have fully overlapping spots!"
        -- Task 2
        let result2 = task2 elfPairs
        putStrLn $ (show result2) ++ " pairs of elves have at least partially overlapping spots!"
        
    task1 :: [ElfPair] -> Int
    task1 = length . filter containedIn

    task2 :: [ElfPair] -> Int
    task2 = length . filter partiallyOverlaps

    containedIn :: ElfPair -> Bool
    containedIn (p1, p2) = p1 `fullyOverlaps` p2 || p2 `fullyOverlaps` p1
    
    fullyOverlaps :: ClearingPatch -> ClearingPatch -> Bool
    fullyOverlaps cp1 cp2 = (fst cp1) >= (fst cp2) && (snd cp1) <= (snd cp2)

    partiallyOverlaps :: ElfPair -> Bool
    partiallyOverlaps (cp1, cp2) 
        | (fst cp1) <= (fst cp2) = (fst cp2) <= (snd cp1)
        | otherwise = (snd cp2) >= (fst cp1)

    preProcessData :: [String] -> [ElfPair]
    preProcessData = map preProcessLine

    preProcessLine :: String -> ElfPair
    preProcessLine l = ((e!!0, e!!1), (e!!2, e!!3))
        where e = map read (splitOneOf ",-" l) :: [Int]

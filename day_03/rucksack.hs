module Main where

    import Data.Char (isUpper, isLower, ord)
    import Data.List (splitAt, length, intersect)
    import Data.List.Utils (uniq)
    import Data.List.Split (chunksOf)

    type Rucksack = String
    type Compartments = (String, String)
    type Group = [String]

    main :: IO ()
    main = do
        input <- readFile "input.txt"
        let rucksacks = lines input
        -- Task 1
        let compartments = map splitRucksacks rucksacks
        let result1 = task1 compartments
        putStrLn $ "The total priority of the common compartment items is " ++ (show result1) ++ "!"
        -- Task 2
        let groups = chunksOf 3 rucksacks
        let result2 = task2 groups
        putStrLn $ "The total priority of the common group items is " ++ (show result2) ++ "!"

    task1 :: [Compartments] -> Int
    task1 r = sum $ map commonItemRucksack r

    task2 :: [Group] -> Int
    task2 g = sum $ map commonItemGroup g

    splitRucksacks :: Rucksack -> Compartments
    splitRucksacks r = splitAt ((length r) `div` 2) r

    commonItemRucksack :: Compartments -> Int
    commonItemRucksack (a, b) = itemPriority $ head $ uniq $ intersect a b

    commonItemGroup :: Group -> Int
    commonItemGroup (e:f:g:xs) = itemPriority $ head $ uniq $ intersect e $ intersect f g

    itemPriority :: Char -> Int
    itemPriority a
        | isLower a = ord a - 96
        | isUpper a = ord a - (65 - 27)

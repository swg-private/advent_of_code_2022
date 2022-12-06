module Main where

    import Data.List (length)
    import Data.List.Utils (uniq)
    import Data.List.Split (divvy)

    type Package = (Int, [Char])

    main :: IO ()
    main = do
        sentData <- readFile "input.txt"
        -- Task 1
        let result1 = task1 sentData
        putStrLn $ (show result1) ++ " is the first index of a start-of-packet marker!"
        -- Task 2
        let result2 = task2 sentData
        putStrLn $ (show result2) ++ " is the first index of a start-of-message marker!"

    task1 :: String -> Int
    task1 = firstMarker potentialPacketMarkers
        where potentialPacketMarkers = potentialMarkerOfLength 4
    
    task2 :: String -> Int
    task2 = firstMarker potentialMessageMarkers
        where potentialMessageMarkers = potentialMarkerOfLength 14

    firstMarker :: (String -> [Package]) -> String -> Int
    firstMarker f d = fst . head . filter isMarker $ f d

    potentialMarkerOfLength :: Int -> String -> [Package]
    potentialMarkerOfLength n d = zip [n..] $ divvy n 1 d

    isMarker :: Package -> Bool
    isMarker (_, d) = length d == length ud
        where ud = uniq d
            
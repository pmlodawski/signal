module Main where

import Control.Concurrent
import System.Signal



main :: IO ()
main = do
    installHandler sigINT (\x -> putStrLn $ "catch " ++ (show x))
    installHandler sigTERM (\x -> putStrLn $ "catch " ++ (show x))
    loop 0

loop :: Int -> IO ()
loop i = do
    print i
    threadDelay 1000000 {- µs -}
    loop (i + 1)

import System.Signal
import Control.Concurrent



main :: IO ()
main = do
    putStrLn "Hello World"
    installHandler 2 (\x->putStrLn $ "catch "++(show x))
    -- mapM_ (\i -> installHandler i (CatchInfo (print . siginfoSignal)) Nothing) [1..50]--sigINT, sigKILL, sigQUIT, sigSTOP]
    -- mapM_ (\i -> setHandler i (Just (handler, undefined))) [1..50]
    -- setUncaughtExceptionHandler (const $ print "SFafG")
    -- catch loopForever (\(e :: SomeException) ->  print "sfafa")
    loop 0

--
--
-- loopForever :: IO ()
-- loopForever = putStrLn "Looping..." >> loopForever' where
--     loopForever' = loopForever'

loop i = do print i
            threadDelay 1000000 {- µs -}
            loop (i + 1)

{-# LANGUAGE CPP #-}

module System.Signal where

#ifdef mingw32_HOST_OS
import Foreign
import Foreign.C.Types
#else
#endif

type Handler = CInt->IO ()

#ifdef mingw32_HOST_OS
foreign import ccall "wrapper"
    genHandler:: (Handler) -> IO (FunPtr Handler)

foreign import ccall safe "signal.h signal"
    install:: CInt->FunPtr Handler->IO CInt

installHandler signal handler = install signal =<< genHandler handler
#else
#endif

main = do
    res <- installHandler 2 (\x->putStrLn $ "catch "++(show x))
    putStrLn $ show res
    s<-getLine

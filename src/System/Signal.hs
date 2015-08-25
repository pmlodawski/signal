{-# LANGUAGE CPP #-}

module System.Signal where

#ifdef mingw32_HOST_OS
import Foreign
import Foreign.C.Types
import Control.Exception.Base (assert)
#else
#endif

type Handler = CInt->IO ()

installHandler :: CInt -> Handler -> IO ()
#ifdef mingw32_HOST_OS
foreign import ccall "wrapper"
    genHandler:: (Handler) -> IO (FunPtr Handler)

foreign import ccall safe "signal.h signal"
    install:: CInt->FunPtr Handler->IO CInt

installHandler signal handler = do
    result <- install signal =<< genHandler handler
    return $ assert (result == 0) ()
#else
#endif

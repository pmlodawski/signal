{-# LANGUAGE CPP #-}

module System.Signal where

import Foreign.C.Types
#ifdef mingw32_HOST_OS
import Control.Exception.Base (assert)
import Foreign
#else
import           Control.Monad        (void)
import qualified System.Posix.Signals as Posix
#endif


type Signal = CInt

-- | SIGABRT - Abnormal termination
sigABRT :: Signal
sigABRT = 6

-- | SIGFPE - Floating-point error
sigFPE :: Signal
sigFPE = 8

-- | SIGILL - Illegal instruction
sigILL :: Signal
sigILL = 4

-- | SIGINT - CTRL+C signal
sigINT :: Signal
sigINT = 2

-- | SIGSEGV - Illegal storage access
sigSEGV :: Signal
sigSEGV = 11

-- | SIGTERM - Termination request
sigTERM :: Signal
sigTERM = 15

type Handler = Signal -> IO ()

installHandler :: Signal -> Handler -> IO ()
#ifdef mingw32_HOST_OS
foreign import ccall "wrapper"
    genHandler:: Handler -> IO (FunPtr Handler)

foreign import ccall safe "signal.h signal"
    install:: Signal -> FunPtr Handler -> IO Signal

installHandler signal handler = do
    result <- install signal =<< genHandler handler
    return $ assert (result == 0) ()
#else
installHandler signal handler = void $ Posix.installHandler signal (Posix.CatchInfo (handler . Posix.siginfoSignal)) Nothing
#endif

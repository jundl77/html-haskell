module Lib
    ( transpile
    ) where

import           Control.Monad
import           Language.Haskell.Interpreter
import           Data.Text        (Text, pack, unpack)
import           Html

transpile :: Text -> IO Text
transpile = html
    where
        html :: Text -> IO Text
        html code = do
            putStrLn $ unpack code
            
            r <- runInterpreter $ do
                setImports ["Prelude", "Html"]
                interpret (unpack code) (as :: () -> String)
            
            case r of
                Left error -> return $ (pack . show) error
                Right renderFunc -> return $ pack $ renderFunc()
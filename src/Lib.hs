module Lib
    ( transpile
    ) where

import           Control.Monad
import           Language.Haskell.Interpreter
import           Data.Text        (Text, pack, unpack)
import           Html

prefix = "\\() -> let renderWrapper = render\n\
          \               where\n"
suffix = "in renderString renderWrapper"
space = "                   "

transpile :: Text -> IO Text
transpile code = do
    putStrLn $ unpack code
    
    r <- runInterpreter $ do
        setImports ["Prelude", "Html"]
        interpret ((prepare . unpack) code) (as :: () -> String)
    
    case r of
        Left error -> return $ (pack . show) error
        Right renderFunc -> return $ pack $ renderFunc()

prepare :: String -> String
prepare str = prefix ++ unlines (map (space++) (lines str)) ++ suffix
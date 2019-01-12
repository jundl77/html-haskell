import Control.Monad
import Language.Haskell.Interpreter
import Html

code :: String
code = "\\() -> let render doc = doc\n\
        \           div content = div_ content\n\
        \           pp = p_ \"hello world\"\n\
        \in renderString $ render $ div pp"

main = transpile code >>= putStrLn

transpile :: String -> IO String
transpile = html
    where
html :: String -> IO String
html code = do
    putStrLn code
    
    r <- runInterpreter $ do
        setImports ["Prelude", "Html"]
        interpret code (as :: () -> String)
    
    case r of
        Left err -> return $ show err
        Right renderFunc -> return $ renderFunc()
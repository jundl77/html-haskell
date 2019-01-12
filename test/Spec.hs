import           Lib

import           Test.Tasty
import           Test.Tasty.HUnit

import           Data.Text        (Text, pack, unpack)
import           Control.Monad.IO.Class


main :: IO ()
main = defaultMain unitTests

result :: String -> IO Text
result str = do
    let a = pack str
    return a

unitTests :: TestTree
unitTests = testGroup "Unit tests" [testA]


codeA :: String
codeA = "render = div $ pp $ genString \"Hello\"\n\
        \\n\
        \div content = div_ content\n\
        \pp content = p_ content\n\
        \\n\
        \genString :: String -> String\n\
        \genString str = str ++ str"

testA = testCase "Test code A:"$ assertEqual [] "hi" "hi"
-- testA = do
--     let expected = liftIO $ result "hi"
--     let actual = liftIO $ result "hi"
--     testCase "Test code A:" $ assertEqual [] expected actual

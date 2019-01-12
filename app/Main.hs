{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where 

  
import           Lib

import           Web.Spock
import           Web.Spock.Config
import           Data.Aeson       hiding (json)
import           Data.Text        (Text, pack)

import           GHC.Generics
import           Control.Monad.IO.Class


type Api = SpockM () () () ()
type ApiAction a = SpockAction () () () a

data PostData = PostData { code :: Text } deriving (Generic, Show)
instance ToJSON PostData
instance FromJSON PostData

port :: Int
port = 3000

main :: IO ()
main = do
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock port (spock spockCfg app)

app :: Api
app = do
  get "status" $ text "200"
  post "transpile" $ do
    postData <- jsonBody' :: ApiAction PostData
    result <- liftIO $ (transpile . code) postData
    text result

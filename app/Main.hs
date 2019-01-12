{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where 

  
import           Lib

import           Web.Spock
import           Web.Spock.Config
import           Data.Aeson       hiding (json)
import           Data.Text        (Text, pack)
import           Network.Wai                      
import           Network.Wai.Middleware.AddHeaders
import           Network.Wai.Middleware.Cors
import           Network.Wai.Middleware.RequestLogger

import           GHC.Generics
import           Control.Monad.IO.Class

type Api = SpockM () () () ()
type ApiAction a = SpockAction () () () a

data PostData = PostData { code :: Text } deriving (Generic, Show)
instance ToJSON PostData
instance FromJSON PostData

main :: IO ()
main = do
  let port = 3001
  let middlewares = fmap ((corsified . logStdoutDev) .)
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock port $ middlewares $ (spock spockCfg app)
  
-- | CORS middleware configured with 'appCorsResourcePolicy'.
corsified :: Middleware
corsified = cors (const $ Just appCorsResourcePolicy)

appCorsResourcePolicy :: CorsResourcePolicy
appCorsResourcePolicy = CorsResourcePolicy {
    corsOrigins        = Nothing
  , corsMethods        = ["OPTIONS", "GET", "PUT", "POST"]
  , corsRequestHeaders = ["Authorization", "Content-Type"]
  , corsExposedHeaders = Nothing
  , corsMaxAge         = Nothing
  , corsVaryOrigin     = False
  , corsRequireOrigin  = False
  , corsIgnoreFailures = False
}

app :: Api
app = do
  get "status" $ text "200"
  post "transpile" $ do
    postData <- jsonBody' :: ApiAction PostData
    result <- liftIO $ (transpile . code) postData
    text result

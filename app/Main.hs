{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

port = 3000

main :: IO ()
main = scotty port $
    get "/status" $ text "200"
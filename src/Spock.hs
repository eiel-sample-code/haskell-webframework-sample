{-# LANGUAGE OverloadedStrings #-}
module Spock where

import Web.Spock
import Data.Aeson hiding (json)
import Data.Maybe
import Add (add, Request(..))
import Util (getPort)


spockSample = do
  port <- getPort
  runSpock port $ spockT id $ do
    get ("add" <//> var <//> var) $ \x y ->
      json $ add x y
    post "add" $ do
      addSampleHeader
      Just (Request x y) <- jsonBody
      json $ add x y

addSampleHeader = do
  headerSample <- header "X-SAMPLE"
  setHeader "X-SAMPLE" . fromMaybe "sample" $ headerSample

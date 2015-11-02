{-# LANGUAGE OverloadedStrings #-}
module Scotty where

import Web.Scotty
import Data.Aeson hiding (json)
import Data.Maybe
import Add (add, Request(..))
import Util (getPort)


scottySample = getPort >>= flip scotty route
  where
    route = do
      get "/add/:x/:y" $ do
        addSampleHeader
        x <- fmap read . param $ "x"
        y <- fmap read . param $ "y"
        json $ add x y
      post "/add" $ do
        addSampleHeader
        Just (Request x y) <- fmap decode body
        json $ add x y


addSampleHeader = do
  headerSample <- header "X-SAMPLE"
  setHeader "X-SAMPLE" . fromMaybe "sample" $ headerSample

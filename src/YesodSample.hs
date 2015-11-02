{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE ViewPatterns          #-}

module YesodSample where

import Yesod (mkYesod, parseRoutes, Yesod(..), selectRep, provideJson, parseJsonBody, warp, lookupHeader, addHeader, renderRoute)
import Add (add, Request(..))
import Data.Aeson.Types (Result(..))
import Data.Maybe (fromMaybe)
import Data.Text.Encoding (decodeUtf8)

data App = App

mkYesod "App" [parseRoutes|
/add/#Integer/#Integer Add1R GET
/add                   Add2R POST
|]

instance Yesod App

getAdd1R x y = do
  addSampleHeader
  selectRep . provideJson $ add x y

postAdd2R = do
  addSampleHeader
  Success (Request x y) <- parseJsonBody
  selectRep . provideJson $ add x y

yesod :: IO ()
yesod = warp 3000 App

addSampleHeader = do
 headerSample <- lookupHeader "X-SAMPLE"
 addHeader "X-SAMPLE" . fromMaybe "sample" $ fmap decodeUtf8 headerSample

{-# LANGUAGE DeriveGeneric #-}
module Add where

import Prelude hiding (add)
import GHC.Generics (Generic)
import Data.Aeson hiding (Result)

data Result = Result { result :: Integer } deriving (Generic, Show)
data Request = Request { x :: Integer, y :: Integer } deriving (Generic, Show)

instance ToJSON Result
instance FromJSON Result
instance ToJSON Request
instance FromJSON Request

add :: Integer -> Integer -> Result
add x y = Result $ x + y

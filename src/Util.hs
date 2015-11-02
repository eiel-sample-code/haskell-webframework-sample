module Util where

import Data.Maybe
import System.Environment (getEnvironment)
import Data.List (lookup)

getPort :: IO Int
getPort = getEnvironment >>= return . port
  where
    port = fromMaybe defaultPort . fmap read . lookup "PORT"

defaultPort = 3000

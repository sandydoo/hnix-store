{-|
Description : Representation of Nix store paths.
-}
module System.Nix.StorePath
  ( -- * Basic store path types
    StoreDir(..)
  , StorePath(..)
  , StorePathName
  , StorePathHashPart
  , mkStorePathHashPart
  , unStorePathHashPart
  , ContentAddressableAddress(..)
  , NarHashMode(..)
  , -- * Manipulating 'StorePathName'
    makeStorePathName
  , unStorePathName
  , validStorePathName
    -- * Reason why a path is not valid
  , InvalidPathError(..)
  , -- * Rendering out 'StorePath's
    storePathToFilePath
  , storePathToRawFilePath
  , storePathToText
  , storePathToNarInfo
  , -- * Parsing 'StorePath's
    parsePath
  , pathParser
  )
where

import           System.Nix.Internal.StorePath

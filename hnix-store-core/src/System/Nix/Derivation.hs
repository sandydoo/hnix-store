-- due to recent generic-arbitrary
{-# OPTIONS_GHC -Wno-orphans -fconstraint-solver-iterations=0 #-}

module System.Nix.Derivation
  ( parseDerivation
  , buildDerivation
  -- Re-exports
  , Derivation(..)
  , DerivationOutput(..)
  ) where

import Data.Attoparsec.Text.Lazy (Parser)
import Data.Text (Text)
import Data.Text.Lazy.Builder (Builder)
import Test.QuickCheck (Arbitrary(..))
import Test.QuickCheck.Arbitrary.Generic (GenericArbitrary(..))
import Test.QuickCheck.Instances ()

import Nix.Derivation (Derivation(..), DerivationOutput(..))
import System.Nix.StorePath (StoreDir, StorePath)

import qualified Data.Attoparsec.Text.Lazy
import qualified Data.Text
import qualified Data.Text.Lazy
import qualified Data.Text.Lazy.Builder

import qualified Nix.Derivation
import qualified System.Nix.StorePath

deriving via GenericArbitrary (Derivation StorePath Text)
  instance Arbitrary (Derivation StorePath Text)
deriving via GenericArbitrary (DerivationOutput StorePath Text)
  instance Arbitrary (DerivationOutput StorePath Text)

parseDerivation :: StoreDir -> Parser (Derivation StorePath Text)
parseDerivation expectedRoot =
  Nix.Derivation.parseDerivationWith
    pathParser
    Nix.Derivation.textParser
  where
    pathParser = do
      text <- Nix.Derivation.textParser
      case Data.Attoparsec.Text.Lazy.parseOnly
            (System.Nix.StorePath.pathParser expectedRoot)
            (Data.Text.Lazy.fromStrict text)
        of
          Right p -> pure p
          Left e -> fail e

buildDerivation :: StoreDir -> Derivation StorePath Text -> Builder
buildDerivation storeDir =
  Nix.Derivation.buildDerivationWith
    (string . System.Nix.StorePath.storePathToText storeDir)
    string
  where
    string = Data.Text.Lazy.Builder.fromText . Data.Text.pack . show

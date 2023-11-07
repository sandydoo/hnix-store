{-# LANGUAGE CPP #-}

module System.Nix.Internal.Nar.Options 
  ( NarOptions(..)
  , defaultNarOptions
  , caseHackSuffix
  ) where

data NarOptions = NarOptions {
  useCaseHack :: Bool
  -- ^ Whether to use the case hack to support case-insensitive filesystems.
  -- Enabled by default on Darwin (macOS).
}

defaultNarOptions :: NarOptions
defaultNarOptions = NarOptions {
#ifdef darwin_HOST_OS
  useCaseHack = True
#else
  useCaseHack = False
#endif
}

caseHackSuffix :: Text
caseHackSuffix = "~nix~case~hack~"

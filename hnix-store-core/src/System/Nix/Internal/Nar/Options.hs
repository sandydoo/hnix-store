{-# LANGUAGE CPP #-}

module System.Nix.Internal.Nar.Options 
  ( NarOptions(..)
  , defaultNarOptions
  , caseHackSuffix
  ) where

data NarOptions = NarOptions {
  useCaseHack :: Bool
  -- ^ Whether to use a case hack to support case-insensitive filesystems.
  -- The case hack rewrites file names to avoid collisions on case-insensitive file systems, e.g. APFS and HFS+ on macOS.
  -- Enabled by default on macOS (Darwin).
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

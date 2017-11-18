
module Keyboard.KeySet exposing (Msg(..), KeySet, insert, remove, member, empty, subscriptions, update)


{-| KeySet data type. Holds the current set of keys pressed.

#  Data types - KeySet for holding a set of Keys, Msg for tracking Up/Down events.

@docs Msg, KeySet

# Set management

@docs insert, remove, empty, member


# Subscription - subscriptions for tracking window keys, update function for tracking state

@docs subscriptions, update

-}

import Keyboard.Key as Key exposing (Key(..))
import Set exposing (Set)

{-| KeySet data type. Holds a set of keys pressed at once.
-}
type alias KeySet = Set String


{-| `KeySet`'s internal message type.
-}
type Msg = Down Key | Up Key


{-| empty `KeySet`
-}
empty : KeySet
empty = Set.empty

{-| insert Key into `KeySet`
-}
insert : Key -> KeySet -> KeySet
insert key set = case key of
  Other -> set
  _     -> Set.insert (toString key) set

{-| remove Key from `KeySet` (or nothing if it does not exist)
-}
remove : Key -> KeySet -> KeySet
remove key set = case key of
  Other -> set
  _     -> Set.remove (toString key) set

{-| is Key a member of `KeySet`?
-}
member :  Key -> KeySet -> Bool
member k set = Set.member (toString k) set

{-| The subscriptions needed for the "Msg and Update" way.
-}
subscriptions : (Msg -> msg) -> Sub msg
subscriptions f =
    Sub.batch
        [ Key.onKeyDown (f << Down)
        , Key.onKeyUp (f << Up)
        ]
{-| update `KeySet` using message.
-}
update : Msg -> KeySet -> KeySet
update msg set = case msg of
  Down k -> insert k set
  Up k   -> remove k set

module Keyboard.Attributes
    exposing
        ( onKeyDown
        , onKeyUp
        , onKeyPress
        , decodeKey
        )

{-| Html event handlers for key events using the Key data type.

# Html event handler attributes

@docs onKeyDown, onKeyUp, onKeyPress

# Decoder

@docs decodeKey

-}

import Keyboard.Key as Key exposing (Key)
import Html exposing (Attribute)
import Html.Events exposing (on)

import Json.Decode as Json


{-| Subscription for key down events.

**Note** When the user presses and holds a key, there may or may not be many of
these messages before the corresponding key up message.

-}
onKeyDown : (Key -> msg) -> Attribute msg
onKeyDown toMsg = on "keydown" (Json.map toMsg decodeKey)


{-| Subscription for key up events.
-}
onKeyUp : (Key -> msg) -> Attribute msg
onKeyUp toMsg = on "keyup" (Json.map toMsg decodeKey)



{-| Subscription for key press events.
-}
onKeyPress : (Key -> msg) -> Attribute msg
onKeyPress toMsg = on "keypress" (Json.map toMsg decodeKey)


{-| A `Json.Decoder` for grabbing `event.keyCode` and turning it into a `Key`
-}
decodeKey : Json.Decoder Key
decodeKey = Key.decodeKey

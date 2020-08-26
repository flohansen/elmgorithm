module Components.Fab exposing (fab)

import Color
import Html exposing (Html, button)
import Html.Attributes exposing (style)
import Material.Icons.Types exposing (Coloring(..), Icon)
import Palette exposing (Palette)
import Types exposing (Msg)


fab : Palette -> Int -> List (Html.Attribute Msg) -> Icon Msg -> Html Msg
fab p size props icon =
    button
        ([ style "border-radius" "50%"
         , style "border" "0"
         , style "padding" "7px 0"
         , style "outline" "none"
         , style "cursor" "pointer"
         , style "color" (Color.toCssString p.textPrimary)
         , style "background" (Color.toCssString p.secondary)
         , style "width" (String.fromInt size ++ "px")
         , style "height" (String.fromInt size ++ "px")
         ]
            ++ props
        )
        [ icon (size // 2) (Color <| Color.rgb 255 255 255) ]

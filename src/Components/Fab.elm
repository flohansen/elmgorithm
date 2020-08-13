module Components.Fab exposing (fab)

import Color
import Html exposing (Html, button)
import Html.Attributes exposing (style)
import Material.Icons.Types exposing (Coloring(..), Icon)
import Palette exposing (Palette)
import Types exposing (Msg)


fab : Palette -> List (Html.Attribute Msg) -> Icon Msg -> Html Msg
fab p props icon =
    button
        ([ style "border-radius" "50%"
         , style "border" "0"
         , style "padding" "7px 0"
         , style "outline" "none"
         , style "cursor" "pointer"
         , style "color" p.textPrimary
         , style "background" p.secondary
         , style "width" "48px"
         , style "height" "48px"
         , style "margin-bottom" "48px"
         ]
            ++ props
        )
        [ icon 24 (Color <| Color.rgb 255 255 255) ]

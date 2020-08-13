module Components.Button exposing (button)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Palette exposing (Palette)
import Types exposing (Msg)


button : Palette -> List (Html.Attribute Msg) -> List (Html Msg) -> Html Msg
button p props l =
    Html.button
        ([ style "display" "block"
         , style "width" "100%"
         , style "border-radius" "3px"
         , style "border" "0"
         , style "padding" "7px 0"
         , style "outline" "none"
         , style "cursor" "pointer"
         , style "color" "#fff"
         , style "background" "#DC2865"
         ]
            ++ props
        )
        l

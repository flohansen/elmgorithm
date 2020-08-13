module Components.Fab exposing (fab)

import Html exposing (Html, button)
import Html.Attributes exposing (style)
import Types exposing (Msg)


fab : List (Html.Attribute Msg) -> List (Html Msg) -> Html Msg
fab props l =
    button
        ([ style "border-radius" "50%"
         , style "border" "0"
         , style "padding" "7px 0"
         , style "outline" "none"
         , style "cursor" "pointer"
         , style "color" "#fff"
         , style "background" "#DC2865"
         , style "width" "48px"
         , style "height" "48px"
         , style "margin-bottom" "48px"
         ]
            ++ props
        )
        l

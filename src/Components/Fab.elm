module Components.Fab exposing (fab)

import Html exposing (Html, button)
import Html.Attributes exposing (style)
import Palette exposing (Palette)
import Types exposing (Msg)


fab : Palette -> List (Html.Attribute Msg) -> List (Html Msg) -> Html Msg
fab p props l =
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
        l

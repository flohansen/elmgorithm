module Components.Menu exposing (menu)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Types exposing (Msg)


menu : List (Html Msg) -> Html Msg
menu l =
    Html.ul
        [ style "list-style" "none"
        , style "padding" "0"
        , style "margin-top" "64px"
        ]
        l

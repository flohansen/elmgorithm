module Components.Row exposing (row)

import Html exposing (Html)
import Html.Attributes exposing (style)


row : List (Html msg) -> Html msg
row l =
    Html.div
        [ style "display" "flex"
        , style "flex-shrink" "1"
        , style "align-items" "center"
        , style "width" "100%"
        , style "margin-bottom" "16px"
        ]
        l

module Components.MenuItem exposing (menuItem)

import Color
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Material.Icons.Types exposing (Coloring(..), Icon)
import Palette exposing (Palette)
import Types exposing (Msg)


menuItem : Palette -> List (Html.Attribute Msg) -> Icon Msg -> String -> Html Msg
menuItem p props icon str =
    Html.li []
        [ Html.button
            ([ style "display" "flex"
             , style "align-items" "center"
             , style "background" "transparent"
             , style "border" "none"
             , style "outline" "none"
             , style "cursor" "pointer"
             , style "width" "100%"
             ]
                ++ props
            )
            [ Html.span
                [ style "margin-right" "24px"
                ]
                [ icon 24 (Color <| Color.rgb 255 255 255)
                ]
            , Typography.body p str
            ]
        ]

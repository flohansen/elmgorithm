module Styles exposing (..)

import Html exposing (Html, p, text)
import Html.Attributes exposing (style)
import Types exposing (Model)


vertSpacing : Int -> Html msg
vertSpacing x =
    Html.div [ style "height" (String.fromInt x ++ "px") ] []


horiSpacing : Int -> Html msg
horiSpacing x =
    Html.div [ style "width" (String.fromInt x ++ "px") ] []


classApp : List (Html.Attribute msg)
classApp =
    [ style "width" "100vw"
    , style "height" "100vh"
    , style "background" "#121212"
    ]


classContent : Model -> List (Html.Attribute msg)
classContent model =
    [ style "width" ("calc(100vw - " ++ String.fromInt (model.appInfo.drawerWidth + model.appInfo.drawerSettingsWidth) ++ "px)")
    , style "height" "100vh"
    , style "position" "relative"
    , style "padding-top" (String.fromInt model.appInfo.appBarHeight ++ "px")
    , style "margin-left" (String.fromInt model.appInfo.drawerWidth ++ "px")
    , style "box-sizing" "border-box"
    ]

module Styles exposing (..)

import Html exposing (Html, p, text)
import Html.Attributes exposing (style)
import Types exposing (Model)


classApp : List (Html.Attribute msg)
classApp =
    [ style "width" "100vw"
    , style "height" "100vh"
    , style "background" "#121212"
    ]


classAppBar : Model -> List (Html.Attribute msg)
classAppBar model =
    [ style "width" ("calc(100% - " ++ String.fromInt model.appInfo.drawerWidth ++ "px)")
    , style "height" (String.fromInt model.appInfo.appBarHeight ++ "px")
    , style "background" "#272727"
    , style "margin-left" (String.fromInt model.appInfo.drawerWidth ++ "px")
    , style "position" "fixed"
    , style "top" "0"
    , style "left" "0"
    , style "display" "flex"
    , style "align-items" "center"
    , style "box-sizing" "border-box"
    , style "padding" "0 24px"
    ]


classDrawerSettings : Model -> List (Html.Attribute msg)
classDrawerSettings model =
    [ style "width" (String.fromInt model.appInfo.drawerSettingsWidth ++ "px")
    , style "height" "100vh"
    , style "background" "#363636"
    , style "position" "fixed"
    , style "top" "0"
    , style "right" "0"
    , style "margin-top" (String.fromInt model.appInfo.appBarHeight ++ "px")
    , style "padding" "24px"
    , style "box-sizing" "border-box"
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

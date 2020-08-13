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


classDrawer : Model -> List (Html.Attribute msg)
classDrawer model =
    [ style "width" (String.fromInt model.appInfo.drawerWidth ++ "px")
    , style "height" "100vh"
    , style "background" "#363636"
    , style "position" "fixed"
    , style "top" "0"
    , style "left" "0"
    , style "box-sizing" "border-box"
    , style "padding" "24px"
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


classRow : List (Html.Attribute msg)
classRow =
    [ style "display" "flex"
    , style "flex-shrink" "1"
    , style "align-items" "center"
    , style "width" "100%"
    , style "margin-bottom" "16px"
    ]


classRowData : List (Html.Attribute msg)
classRowData =
    [ style "flex-grow" "1"
    , style "min-width" "0"
    , style "border" "0"
    , style "background" "rgba(255, 255, 255, 0.15)"
    , style "border-radius" "3px"
    , style "padding" "5px 7px"
    , style "font-size" "14px"
    , style "color" "#fff"
    , style "letter-spacing" "0.04em"
    ]


classSelectOption : List (Html.Attribute msg)
classSelectOption =
    [ style "background" "#000"
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

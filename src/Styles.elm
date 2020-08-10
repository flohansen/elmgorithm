module Styles exposing (..)

import Html exposing (Html, p, text)
import Html.Attributes exposing (style)
import Types exposing (Model)


type TypographyType
    = Header
    | Body
    | Label
    | Button
    | Caption
    | Subheader


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


classButton : List (Html.Attribute msg)
classButton =
    [ style "display" "block"
    , style "width" "100%"
    , style "border-radius" "3px"
    , style "border" "0"
    , style "padding" "7px 0"
    , style "outline" "none"
    , style "cursor" "pointer"
    , style "color" "#fff"
    , style "background" "#DC2865"
    ]


classFab : List (Html.Attribute msg)
classFab =
    [ style "border-radius" "50%"
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


classContent : Model -> List (Html.Attribute msg)
classContent model =
    [ style "width" ("calc(100vw - " ++ String.fromInt (model.appInfo.drawerWidth + model.appInfo.drawerSettingsWidth) ++ "px)")
    , style "height" "100vh"
    , style "position" "relative"
    , style "padding-top" (String.fromInt model.appInfo.appBarHeight ++ "px")
    , style "margin-left" (String.fromInt model.appInfo.drawerWidth ++ "px")
    , style "box-sizing" "border-box"
    ]


classTypo : List (Html.Attribute msg)
classTypo =
    [ style "padding" "0"
    , style "margin" "0"
    , style "font-family" "Arial"
    ]


classTypoHeader : List (Html.Attribute msg)
classTypoHeader =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "20px"
           , style "color" "#ffffff"
           ]


classTypoBody : List (Html.Attribute msg)
classTypoBody =
    classTypo
        ++ [ style "font-weight" "400"
           , style "font-size" "16px"
           , style "color" "#ffffff"
           ]


classTypoLabel : List (Html.Attribute msg)
classTypoLabel =
    classTypo
        ++ [ style "flex" "0 1 auto"
           , style "margin-right" "16px"
           , style "font-size" "16px"
           , style "color" "#A7A7A7"
           , style "letter-spacing" "0.04em"
           ]


classTypoButton : List (Html.Attribute msg)
classTypoButton =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "12px"
           , style "letter-spacing" "0.18em"
           , style "text-transform" "uppercase"
           ]


classTypoCaption : List (Html.Attribute msg)
classTypoCaption =
    classTypo
        ++ [ style "font-size" "12px"
           , style "letter-spacing" "0.18em"
           , style "text-transform" "uppercase"
           , style "color" "#fff"
           , style "margin-bottom" "24px"
           ]


classMenu : List (Html.Attribute msg)
classMenu =
    [ style "list-style" "none"
    , style "padding" "0"
    , style "margin-top" "64px"
    ]


classMenuItem : List (Html.Attribute msg)
classMenuItem =
    [ style "display" "flex"
    , style "align-items" "center"
    , style "background" "transparent"
    , style "border" "none"
    , style "outline" "none"
    , style "cursor" "pointer"
    , style "width" "100%"
    ]


classMenuItemIcon : List (Html.Attribute msg)
classMenuItemIcon =
    [ style "margin-right" "24px"
    ]


classTypoSubheader : List (Html.Attribute msg)
classTypoSubheader =
    classTypo
        ++ [ style "font-size" "14px"
           , style "color" "#A7A7A7"
           , style "margin-right" "8px"
           ]


typography : TypographyType -> String -> Html msg
typography typoType str =
    case typoType of
        Header ->
            p classTypoHeader [ text str ]

        Body ->
            p classTypoBody [ text str ]

        Label ->
            p classTypoLabel [ text str ]

        Button ->
            p classTypoButton [ text str ]

        Caption ->
            p classTypoCaption [ text str ]

        Subheader ->
            p classTypoSubheader [ text str ]

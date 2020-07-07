module Main exposing (..)

import Browser
import Color
import Html exposing (Html, div, li, p, span, text, ul)
import Html.Attributes exposing (style)
import Material.Icons as Filled exposing (sort)
import Material.Icons.Types exposing (Coloring(..))


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
    [ style "font-weight" "700"
    ]


classTypoButton : List (Html.Attribute msg)
classTypoButton =
    [ style "font-weight" "700"
    ]


classTypoCaption : List (Html.Attribute msg)
classTypoCaption =
    [ style "font-weight" "700"
    ]


classMenu : List (Html.Attribute msg)
classMenu =
    [ style "list-style" "none"
    , style "padding" "0"
    ]


classMenuItem : List (Html.Attribute msg)
classMenuItem =
    [ style "display" "flex"
    , style "align-items" "center"
    ]


classMenuItemIcon : List (Html.Attribute msg)
classMenuItemIcon =
    [ style "margin-right" "24px"
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


type TypographyType
    = Header
    | Body
    | Label
    | Button
    | Caption


type Msg
    = None


type Menu
    = Sort


type alias AppInfo =
    { name : String
    , drawerWidth : Int
    , drawerSettingsWidth : Int
    , appBarHeight : Int
    , currentMenuSelection : Menu
    }


type alias Model =
    { appInfo : AppInfo
    }


menuItemName : Menu -> String
menuItemName m =
    case m of
        Sort ->
            "Sortieralgorithmen"


init : () -> ( Model, Cmd Msg )
init _ =
    ( { appInfo =
            { name = "Elmgorithm"
            , drawerWidth = 320
            , drawerSettingsWidth = 280
            , appBarHeight = 60
            , currentMenuSelection = Sort
            }
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div classApp
        [ div (classAppBar model)
            [ typography Header (menuItemName model.appInfo.currentMenuSelection)
            ]
        , div (classDrawer model)
            [ typography Header model.appInfo.name
            , ul classMenu
                [ li classMenuItem
                    [ span classMenuItemIcon [ Filled.sort 24 (Color <| Color.rgb 255 255 255) ]
                    , typography Body "Sortieralgorithmen"
                    ]
                ]
            ]
        , div (classDrawerSettings model) []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }

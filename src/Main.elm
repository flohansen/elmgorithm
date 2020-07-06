module Main exposing (..)

import Browser
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (style)


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
    [ style "font-weight" "700"
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

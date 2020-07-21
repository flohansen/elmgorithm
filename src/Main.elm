module Main exposing (..)

import Browser
import Color
import Html exposing (Html, a, button, div, input, li, p, select, span, text, ul)
import Html.Attributes exposing (href, style)
import Html.Events exposing (onClick)
import Material.Icons as Filled exposing (sort)
import Material.Icons.Types exposing (Coloring(..))
import Styles exposing (..)
import Types exposing (Menu(..), Model, Msg(..))


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


sortingSettingsView : Model -> Html Msg
sortingSettingsView model =
    div []
        [ typography Caption "Einstellungen"
        , div classRow
            [ typography Label "Algorithmus"
            , select classRowData []
            ]
        , div classRow
            [ typography Label "Elemente"
            , input classRowData []
            ]
        , button classButton [ typography Button "Neue Werte" ]
        ]


view : Model -> Html Msg
view model =
    div classApp
        [ div (classAppBar model)
            [ typography Header (menuItemName model.appInfo.currentMenuSelection)
            ]
        , div (classDrawer model)
            [ typography Header model.appInfo.name
            , ul classMenu
                [ li []
                    [ button
                        (onClick (Navigate Sort)
                            :: classMenuItem
                        )
                        [ span classMenuItemIcon [ Filled.sort 24 (Color <| Color.rgb 255 255 255) ]
                        , typography Body "Sortieralgorithmen"
                        ]
                    ]
                ]
            ]
        , div (classDrawerSettings model)
            [ sortingSettingsView model
            ]
        , div (classContent model)
            []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        Navigate menuOption ->
            let
                oldAppInfo =
                    model.appInfo

                newAppInfo =
                    { oldAppInfo | currentMenuSelection = menuOption }
            in
            ( { model | appInfo = newAppInfo }, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }

module Main exposing (..)

import Browser
import Color
import Html exposing (Html, a, button, div, input, li, p, select, span, text, ul)
import Html.Attributes exposing (href, style, value)
import Html.Events exposing (onClick, onInput)
import Material.Icons as Filled exposing (sort)
import Material.Icons.Types exposing (Coloring(..))
import Random
import Sort exposing (quickSort)
import Styles exposing (..)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (fill, height, viewBox, width, x, y)
import Types exposing (Menu(..), Model, Msg(..))


menuItemName : Menu -> String
menuItemName m =
    case m of
        SortMenu ->
            "Sortieralgorithmen"


listGenerator : Int -> Random.Generator (List Float)
listGenerator n =
    Random.list n (Random.float 0 1)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { appInfo =
            { name = "Elmgorithm"
            , drawerWidth = 320
            , drawerSettingsWidth = 280
            , appBarHeight = 60
            , currentMenuSelection = SortMenu
            }
      , items = [ 1, 0.3, 0.6, 0.4, 0.8 ]
      , numItems = 10
      }
    , Random.generate NewValues (listGenerator 10)
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


sortingSettingsView : Model -> Html Msg
sortingSettingsView model =
    div []
        [ button (onClick Sort :: classFab) [ Filled.play_arrow 24 (Color <| Color.rgb 255 255 255) ]
        , typography Caption "Einstellungen"
        , div classRow
            [ typography Label "Algorithmus"
            , select classRowData []
            ]
        , div classRow
            [ typography Label "Elemente"
            , input ([ value (String.fromInt model.numItems), onInput ChangeNumItems ] ++ classRowData) []
            ]
        , button (onClick GenValues :: classButton) [ typography Button "Neue Werte" ]
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
                        (onClick (Navigate SortMenu)
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
            [ svg
                [ width "100%"
                , height "100%"
                , viewBox "0 0 1 1"
                ]
                (itemsToSvg model.items)
            ]
        ]


itemsToSvg : List Float -> List (Svg msg)
itemsToSvg items =
    let
        itemWidth =
            1.0 / toFloat (List.length items)
    in
    List.indexedMap
        (\i value ->
            rect
                [ width (String.fromFloat itemWidth)
                , height (String.fromFloat value)
                , fill "rgba(255, 255, 255, 0.25)"
                , x (String.fromFloat (toFloat i * itemWidth))
                , y (String.fromFloat (1.0 - value))
                ]
                []
        )
        items


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        GenValues ->
            ( model, Random.generate NewValues (listGenerator model.numItems) )

        NewValues values ->
            ( { model | items = values }, Cmd.none )

        ChangeNumItems value ->
            let
                newNumItems =
                    Maybe.withDefault 0 (String.toInt value)
            in
            ( { model | numItems = newNumItems }, Random.generate NewValues (listGenerator newNumItems) )

        Sort ->
            ( { model | items = quickSort model.items }, Cmd.none )

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

module Main exposing (..)

import Browser
import Color
import Components.RangeBar exposing (rangeBar)
import Components.Typography exposing (TypographyType(..), typography)
import Html exposing (Html, a, button, div, input, li, option, p, select, span, text, ul)
import Html.Attributes exposing (href, style, value)
import Html.Events exposing (onClick, onInput)
import Material.Icons as Filled exposing (sort)
import Material.Icons.Types exposing (Coloring(..))
import Palette
import Random
import Sort exposing (animationFrames, bubbleSort, insertionSort, mergeSort, quickSort)
import Styles exposing (..)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (fill, height, viewBox, width, x, y)
import Time
import Tuple exposing (second)
import Types exposing (AnimationFrame, AnimationState(..), Item, Menu(..), Model, Msg(..))


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
      , animationInfo =
            { speed = 16
            , minSpeed = 200
            , maxSpeed = 16
            , numberFrames = 0
            , animation = []
            , comparisons = 0
            }
      , palette = Palette.dark
      , state = Stopped
      , items = []
      , numItems = 100
      , algorithm = mergeSort
      }
    , Random.generate NewValues (listGenerator 100)
    )


startStopButton : Model -> Html Msg
startStopButton model =
    case model.state of
        Running ->
            button (onClick StopAnimation :: classFab) [ Filled.stop 24 (Color <| Color.rgb 255 255 255) ]

        Stopped ->
            button (onClick StartAnimation :: classFab) [ Filled.play_arrow 24 (Color <| Color.rgb 255 255 255) ]


sortingSettingsView : Model -> Html Msg
sortingSettingsView model =
    div []
        [ startStopButton model
        , typography Caption "Einstellungen"
        , div classRow
            [ typography Label "Algorithmus"
            , select (onInput ChangeSortAlgo :: classRowData)
                [ option (value "mergeSort" :: classSelectOption) [ text "Merge Sort" ]
                , option (value "bubbleSort" :: classSelectOption) [ text "Bubble Sort" ]
                , option (value "quickSort" :: classSelectOption) [ text "Quick Sort" ]
                , option (value "insertionSort" :: classSelectOption) [ text "Insertion Sort" ]
                ]
            ]
        , div classRow
            [ typography Label "Elemente"
            , input ([ value (String.fromInt model.numItems), onInput ChangeNumItems ] ++ classRowData) []
            ]
        , button (onClick GenValues :: classButton) [ typography Button "Neue Werte" ]
        ]


dot : String -> Html Msg
dot color =
    div
        [ style "background" color
        , style "width" "5px"
        , style "height" "5px"
        , style "border-radius" "50%"
        , style "margin-right" "16px"
        ]
        []


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
            [ div [ style "height" "65px", style "display" "flex", style "padding" "0 24px", style "justify-content" "space-between" ]
                [ div
                    [ style "display" "flex"
                    , style "align-items" "center"
                    ]
                    [ dot "red"
                    , "Verglichene Elemente" |> typography Subheader
                    ]
                , div
                    [ style "display" "flex"
                    , style "align-items" "center"
                    ]
                    [ "Vergleiche:" |> typography Subheader
                    , model.animationInfo.comparisons |> String.fromInt |> typography Subheader
                    ]
                ]
            , svg
                [ width "100%"
                , style "height" "calc(100% - 65px)"
                , style "display" "block"
                , viewBox "0 0 1 1"
                ]
                (itemsToSvg model.items 0.001)
            , rangeBar
            ]
        ]


itemsToSvg : List Item -> Float -> List (Svg msg)
itemsToSvg items spacing =
    let
        totalSpacing =
            toFloat (List.length items - 1) * spacing

        itemWidth =
            (1.0 - totalSpacing) / toFloat (List.length items)
    in
    List.indexedMap
        (\i item ->
            rect
                [ width (String.fromFloat itemWidth)
                , height (String.fromFloat item.value)
                , fill item.color
                , x (String.fromFloat (toFloat i * (itemWidth + spacing)))
                , y (String.fromFloat (1.0 - item.value))
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
            ( { model | items = List.map (\x -> { value = x, color = "rgba(255, 255, 255, 0.15)", animation = "" }) values }, Cmd.none )

        ChangeNumItems value ->
            let
                newNumItems =
                    Maybe.withDefault 0 (String.toInt value)
            in
            ( { model | numItems = newNumItems }, Random.generate NewValues (listGenerator newNumItems) )

        ChangeSortAlgo value ->
            let
                algo =
                    case value of
                        "mergeSort" ->
                            mergeSort

                        "quickSort" ->
                            quickSort

                        "bubbleSort" ->
                            bubbleSort

                        "insertionSort" ->
                            insertionSort

                        _ ->
                            mergeSort
            in
            ( { model | algorithm = algo }, Cmd.none )

        ChangeAnimationSpeed value ->
            let
                perc =
                    (String.toFloat value |> Maybe.withDefault 0) / 100.0

                speed =
                    (model.animationInfo.maxSpeed - model.animationInfo.minSpeed)
                        * perc
                        + model.animationInfo.minSpeed

                animationInfo =
                    model.animationInfo

                newAnimationInfo =
                    { animationInfo | speed = speed }
            in
            ( { model | animationInfo = newAnimationInfo }, Cmd.none )

        StartAnimation ->
            let
                animation =
                    model.items |> model.algorithm |> animationFrames

                numberFrames =
                    List.length animation

                animationInfo =
                    model.animationInfo

                newAnimationInfo =
                    { animationInfo
                        | numberFrames = numberFrames
                        , animation = animation
                        , comparisons = 0
                    }
            in
            ( { model | state = Running, animationInfo = newAnimationInfo }, Cmd.none )

        StopAnimation ->
            ( { model
                | state = Stopped
              }
            , Cmd.none
            )

        Tick ->
            let
                frame =
                    model.animationInfo.animation |> List.head

                newAnimation =
                    model.animationInfo.animation |> List.tail |> Maybe.withDefault []
            in
            case frame of
                Just f ->
                    if model.state == Running then
                        ( { model
                            | items = f.items
                            , animationInfo =
                                { speed = model.animationInfo.speed
                                , minSpeed = model.animationInfo.minSpeed
                                , maxSpeed = model.animationInfo.maxSpeed
                                , numberFrames = model.animationInfo.numberFrames
                                , animation = newAnimation
                                , comparisons = model.animationInfo.comparisons + f.comparisons
                                }
                          }
                        , Cmd.none
                        )

                    else
                        ( model, Cmd.none )

                Nothing ->
                    ( { model | state = Stopped }, Cmd.none )

        Navigate menuOption ->
            let
                oldAppInfo =
                    model.appInfo

                newAppInfo =
                    { oldAppInfo | currentMenuSelection = menuOption }
            in
            ( { model | appInfo = newAppInfo }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        dt =
            model.animationInfo.speed * 1000.0 / toFloat model.animationInfo.numberFrames
    in
    Time.every dt (\_ -> Tick)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }

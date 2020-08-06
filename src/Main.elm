module Main exposing (..)

import Browser
import Color
import Html exposing (Html, a, button, div, input, li, option, p, select, span, text, ul)
import Html.Attributes exposing (href, style, value)
import Html.Events exposing (onClick, onInput)
import Material.Icons as Filled exposing (sort)
import Material.Icons.Types exposing (Coloring(..))
import Random
import Sort exposing (bubbleSort, insertionSort, keyFrames, mergeSort, quickSort)
import Styles exposing (..)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (fill, height, viewBox, width, x, y)
import Time
import Tuple exposing (second)
import Types exposing (AnimationState(..), Item, Menu(..), Model, Msg(..), SortAlgorithm(..))


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
      , state = Stopped
      , items = []
      , numItems = 100
      , animationLog = []
      , sortAlgo = MergeSort
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
                (itemsToSvg model.items 0.001)
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
                            MergeSort

                        "quickSort" ->
                            QuickSort

                        "bubbleSort" ->
                            BubbleSort

                        "insertionSort" ->
                            InsertionSort

                        _ ->
                            MergeSort
            in
            ( { model | sortAlgo = algo }, Cmd.none )

        StartAnimation ->
            case model.sortAlgo of
                MergeSort ->
                    ( { model | state = Running, animationLog = mergeSort model.items |> keyFrames }, Cmd.none )

                QuickSort ->
                    ( { model | state = Running, animationLog = quickSort model.items |> keyFrames }, Cmd.none )

                BubbleSort ->
                    ( { model | state = Running, animationLog = bubbleSort model.items |> keyFrames }, Cmd.none )

                InsertionSort ->
                    ( { model | state = Running, animationLog = insertionSort model.items |> keyFrames }, Cmd.none )

        StopAnimation ->
            ( { model | state = Stopped }, Cmd.none )

        Tick ->
            let
                frame =
                    model.animationLog |> List.head

                newAnimationLog =
                    model.animationLog |> List.tail |> Maybe.withDefault []
            in
            case frame of
                Just f ->
                    if model.state == Running then
                        ( { model | items = frame |> Maybe.withDefault [], animationLog = newAnimationLog }, Cmd.none )

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
    Time.every 16 (\_ -> Tick)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }

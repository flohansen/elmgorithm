module Main exposing (..)

import Browser
import Color
import Components.AnimationPreview exposing (animationPreview)
import Components.Button exposing (button)
import Components.Menu exposing (menu)
import Components.MenuItem exposing (menuItem)
import Components.Navigation exposing (navigation)
import Components.RangeBar exposing (rangeBar)
import Components.SortSettings exposing (sortSettings)
import Components.StatisticsBar exposing (statisticsBar)
import Components.Typography as Typography
import Html exposing (Html, a, div, input, li, option, p, select, span, text, ul)
import Html.Attributes exposing (href, style, value)
import Html.Events exposing (onClick, onInput)
import Material.Icons as Filled exposing (sort)
import Material.Icons.Types exposing (Coloring(..))
import Palette
import Random
import Sort exposing (animationFrames, bubbleSort, insertionSort, mergeSort, quickSort)
import Styles exposing (..)
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


view : Model -> Html Msg
view model =
    div classApp
        [ div (classAppBar model)
            [ Typography.header model.palette (menuItemName model.appInfo.currentMenuSelection)
            ]
        , navigation model
        , div (classDrawerSettings model)
            [ sortSettings model
            ]
        , div (classContent model)
            [ statisticsBar model
            , animationPreview model
            , rangeBar model.palette
            ]
        ]


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

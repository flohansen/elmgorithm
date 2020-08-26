module Components.SortSettings exposing (sortSettings)

import Components.Button exposing (button)
import Components.DropDownItem exposing (dropDownItem)
import Components.Fab exposing (fab)
import Components.Row exposing (row)
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)
import Material.Icons as Filled
import Styles exposing (vertSpacing)
import Types exposing (AnimationState(..), Model, Msg(..))


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


startStopButton : Model -> Html Msg
startStopButton model =
    case model.state of
        Running ->
            fab model.palette [ onClick StopAnimation ] Filled.stop

        Stopped ->
            fab model.palette [ onClick StartAnimation ] Filled.play_arrow


sortSettings : Model -> Html Msg
sortSettings model =
    Html.div []
        [ startStopButton model
        , Typography.caption model.palette "Settings"
        , vertSpacing 24
        , row
            [ Typography.label model.palette "Algorithm"
            , Html.select (onInput ChangeSortAlgo :: classRowData)
                [ dropDownItem model.palette "mergeSort" "Merge Sort"
                , dropDownItem model.palette "bubbleSort" "Bubble Sort"
                , dropDownItem model.palette "quickSort" "Quick Sort"
                , dropDownItem model.palette "insertionSort" "Insertion Sort"
                ]
            ]
        , row
            [ Typography.label model.palette "Elements"
            , Html.input ([ value (String.fromInt model.numItems), onInput ChangeNumItems ] ++ classRowData) []
            ]
        , button model.palette [ onClick GenValues ] "New elements"
        ]

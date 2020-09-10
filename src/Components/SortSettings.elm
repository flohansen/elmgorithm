module Components.SortSettings exposing (sortSettings)

import Color
import Components.Button exposing (button)
import Components.DropDownItem exposing (dropDownItem)
import Components.Row exposing (row)
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Styles exposing (vertSpacing)
import Types exposing (Msg(..))


classRowData : Model -> List (Html.Attribute msg)
classRowData model =
    [ style "flex-grow" "1"
    , style "min-width" "0"
    , style "border" "0"
    , style "background" (Color.toCssString model.palette.primary)
    , style "opacity" "0.5"
    , style "border-radius" "3px"
    , style "padding" "5px 7px"
    , style "font-size" "14px"
    , style "color" "#fff"
    , style "letter-spacing" "0.04em"
    ]


sortSettings : Model -> Html Msg
sortSettings model =
    Html.div []
        [ Typography.caption model.palette "Settings"
        , vertSpacing 24
        , row
            [ Typography.label model.palette "Algorithm"
            , Html.select (onInput ChangeSortAlgo :: classRowData model)
                [ dropDownItem model.palette "mergeSort" "Merge Sort"
                , dropDownItem model.palette "bubbleSort" "Bubble Sort"
                , dropDownItem model.palette "quickSort" "Quick Sort"
                , dropDownItem model.palette "insertionSort" "Insertion Sort"
                ]
            ]
        , row
            [ Typography.label model.palette "Elements"
            , Html.input ([ value (String.fromInt model.numItems), onInput ChangeNumItems ] ++ classRowData model) []
            ]
        , button model.palette [ onClick GenValues ] "New elements"
        ]

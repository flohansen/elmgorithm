module Components.HelpDialog exposing (helpDialog)

import Color
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Palette exposing (Palette)
import Styles exposing (vertSpacing)
import Types exposing (Model, Msg(..), SortAlgorithm(..))


complexity : Palette -> String -> String -> Html Msg
complexity palette str compl =
    Html.div
        []
        [ Typography.caption palette str
        , vertSpacing 8
        , Typography.code palette compl
        ]


algorithmName : SortAlgorithm -> String
algorithmName algo =
    case algo of
        MergeSort ->
            "Merge Sort"

        QuickSort ->
            "Quick Sort"

        BubbleSort ->
            "Bubble Sort"

        InsertionSort ->
            "Insertion Sort"


algorithmDescription : SortAlgorithm -> String
algorithmDescription algo =
    case algo of
        MergeSort ->
            "Merge sort is a Divide and Conquer algorithm. First it divides the input array in two parts. Then the algorithm is executed for each of the two parts of the list. Here the recursion takes place. Now the algorithm merges the two sorted parts into one."

        QuickSort ->
            "Quick sort is a Divide and Conquer algorithm. First the algorithm picks the first element of the list, called the pivot. Then it goes over the rest of the list and compares every element with the pivot. If the value of the element is less than the pivot, it puts the element before the pivot. Otherwise it places it after the pivot. Then the algorithm will be executed with the two separated lists (before and after the pivot) until the initial list is sorted."

        BubbleSort ->
            "Bubble sort is one of the simplest sorting algorithm. Starting with the first element of the list, it compares always two adjacent elements. If the left element is greater than the right one, it swaps both elements. The algorithm will continue until the end is reached. After this step, the greatest element is at the end of the list. Next the algorithm will be executed using the previous sorted list as input. This will be repeated until no swap takes place."

        InsertionSort ->
            "The insertion sort algorithm starts with the first element of the list and puts it into the sorted output list. Then take the next element and compare it with each element of the sorted list. Shift all greater elements and insert the value. Repeat it until the input list is empty."


algorithmComplexities : SortAlgorithm -> ( String, String, String )
algorithmComplexities algo =
    case algo of
        MergeSort ->
            ( "O(n log n)", "O(n log n)", "O(n log n)" )

        QuickSort ->
            ( "O(n²)", "O(n log n)", "O(n log n)" )

        BubbleSort ->
            ( "O(n²)", "O(n)", "O(n²)" )

        InsertionSort ->
            ( "O(n²)", "O(n)", "O(n²)" )


helpDialog : Model -> Html Msg
helpDialog model =
    let
        dialogTitle =
            algorithmName model.algorithmType

        dialogText =
            algorithmDescription model.algorithmType

        ( worstCase, bestCase, average ) =
            algorithmComplexities model.algorithmType
    in
    Html.div
        [ style "position" "absolute"
        , style "top" "0"
        , style "left" "0"
        , style "width" "100%"
        , style "height" "100%"
        , style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        ]
        [ Html.div
            [ style "background" "rgba(0, 0, 0, 0.6)"
            , style "width" "100%"
            , style "height" "100%"
            , style "position" "absolute"
            , style "z-index" "0"
            , onClick (ShowAlgorithmInfo False)
            ]
            []
        , Html.div
            [ style "background" (Color.toCssString model.palette.backgroundCard)
            , style "padding" "24px"
            , style "border-radius" "15px"
            , style "max-width" "600px"
            , style "position" "relative"
            , style "z-index" "1"
            ]
            [ Typography.cardHeader model.palette dialogTitle
            , vertSpacing 16
            , Typography.body model.palette dialogText
            , vertSpacing 32
            , Html.div
                [ style "display" "flex"
                , style "justify-content" "space-between"
                ]
                [ complexity model.palette "Worst case" worstCase
                , complexity model.palette "Best case" bestCase
                , complexity model.palette "Average" average
                ]
            ]
        ]

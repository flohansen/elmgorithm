module Components.HelpDialog exposing (helpDialog)

import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Palette exposing (Palette)
import Types exposing (Model, Msg(..), SortAlgorithm(..))


vertSpacing : Int -> Html msg
vertSpacing x =
    Html.div [ style "height" (String.fromInt x ++ "px") ] []


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
            ""

        QuickSort ->
            ""

        BubbleSort ->
            ""

        InsertionSort ->
            ""


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
            [ style "background" model.palette.backgroundCard
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

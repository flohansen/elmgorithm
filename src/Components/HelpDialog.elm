module Components.HelpDialog exposing (helpDialog)

import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Palette exposing (Palette)
import Types exposing (Model, Msg(..))


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


helpDialog : Model -> Html Msg
helpDialog model =
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
            [ Typography.cardHeader model.palette "Merge Sort"
            , vertSpacing 16
            , Typography.body model.palette "First divide the list into the smallest unit (1 element), then compare each element with the adjacent list to sort and merge the two adjacent lists. Finally all the elements are sorted and merged."
            , vertSpacing 32
            , Html.div
                [ style "display" "flex"
                , style "justify-content" "space-between"
                ]
                [ complexity model.palette "Worst case" "O(n log n)"
                , complexity model.palette "Best case" "O(n log n)"
                , complexity model.palette "Average" "O(n log n)"
                ]
            ]
        ]

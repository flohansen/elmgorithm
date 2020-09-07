module Components.StatisticsBar exposing (statisticsBar)

import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Model exposing (Model)
import Types exposing (Msg)


dot : String -> Html Msg
dot color =
    Html.div
        [ style "background" color
        , style "width" "5px"
        , style "height" "5px"
        , style "border-radius" "50%"
        , style "margin-right" "16px"
        ]
        []


statisticsBar : Model -> Html Msg
statisticsBar model =
    Html.div
        [ style "height" "65px"
        , style "display" "flex"
        , style "padding" "0 24px"
        , style "justify-content" "space-between"
        ]
        [ Html.div
            [ style "display" "flex"
            , style "align-items" "center"
            ]
            [ dot "red"
            , Typography.subheader model.palette "Compared elements"
            ]
        , Html.div
            [ style "display" "flex"
            , style "align-items" "center"
            ]
            [ Typography.subheader model.palette "Comparisons:"
            , model.animationInfo.comparisons |> String.fromInt |> Typography.subheader model.palette
            ]
        ]

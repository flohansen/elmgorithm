module Components.RangeBar exposing (rangeBar)

import Components.Typography as Typography
import Html exposing (Html, div, input, label, text)
import Html.Attributes exposing (style, type_)
import Html.Events exposing (onInput)
import Types exposing (Model, Msg(..))


rangeBar : Model -> Html Msg
rangeBar model =
    div
        [ style "display" "flex"
        , style "position" "absolute"
        , style "bottom" "0"
        , style "left" "50%"
        , style "background" "#272727"
        , style "color" "#eee"
        , style "transform" "translateX(-50%)"
        , style "box-sizing" "border-box"
        , style "padding" "24px 48px"
        , style "border-top-left-radius" "20px"
        , style "border-top-right-radius" "20px"
        , style "box-shadow" "0 0 24px rgba(0, 0, 0, 0.15)"
        ]
        [ label [] [ Typography.label model.palette "Animation speed" ]
        , input
            [ type_ "range"
            , Html.Attributes.min "0"
            , Html.Attributes.max "100"
            , onInput ChangeAnimationSpeed
            ]
            []
        ]

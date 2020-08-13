module Components.AnimationPreview exposing (animationPreview)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (fill, height, viewBox, width, x, y)
import Types exposing (Item, Model, Msg)


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


animationPreview : Model -> Html Msg
animationPreview model =
    svg
        [ width "100%"
        , style "height" "calc(100% - 65px)"
        , style "display" "block"
        , viewBox "0 0 1 1"
        ]
        (itemsToSvg model.items 0.001)

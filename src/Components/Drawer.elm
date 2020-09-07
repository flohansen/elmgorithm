module Components.Drawer exposing (drawer)

import Color
import Html exposing (Html)
import Html.Attributes exposing (style)
import Model exposing (Model)
import Types exposing (Msg)


drawer : Model -> List (Html Msg) -> Html Msg
drawer model elements =
    Html.div
        [ style "width" (String.fromInt model.appInfo.drawerSettingsWidth ++ "px")
        , style "height" "100vh"
        , style "background" (Color.toCssString model.palette.backgroundCard)
        , style "position" "fixed"
        , style "top" "0"
        , style "right" "0"
        , style "margin-top" (String.fromInt model.appInfo.appBarHeight ++ "px")
        , style "padding" "24px"
        , style "box-sizing" "border-box"
        ]
        elements

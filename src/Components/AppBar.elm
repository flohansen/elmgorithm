module Components.AppBar exposing (appBar)

import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Types exposing (Menu(..), Model, Msg)


menuItemName : Menu -> String
menuItemName m =
    case m of
        SortMenu ->
            "Sort algorithms"


appBar : Model -> Html Msg
appBar model =
    Html.div
        [ style "width" ("calc(100% - " ++ String.fromInt model.appInfo.drawerWidth ++ "px)")
        , style "height" (String.fromInt model.appInfo.appBarHeight ++ "px")
        , style "background" "#272727"
        , style "margin-left" (String.fromInt model.appInfo.drawerWidth ++ "px")
        , style "position" "fixed"
        , style "top" "0"
        , style "left" "0"
        , style "display" "flex"
        , style "align-items" "center"
        , style "box-sizing" "border-box"
        , style "padding" "0 24px"
        ]
        [ Typography.header model.palette (menuItemName model.appInfo.currentMenuSelection)
        ]

module Components.AppBar exposing (appBar)

import Color
import Components.Fab exposing (fab)
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Material.Icons as Filled
import Model exposing (Model)
import Types exposing (Menu(..), Msg(..))


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
        , style "background" (Color.toCssString model.palette.primary)
        , style "margin-left" (String.fromInt model.appInfo.drawerWidth ++ "px")
        , style "position" "fixed"
        , style "top" "0"
        , style "left" "0"
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "space-between"
        , style "box-sizing" "border-box"
        , style "padding" "0 24px"
        ]
        [ Typography.header model.palette (menuItemName model.appInfo.currentMenuSelection)
        , fab model.palette 32 [ onClick ToggleTheme ] Filled.wb_sunny
        ]

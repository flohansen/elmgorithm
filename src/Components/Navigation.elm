module Components.Navigation exposing (navigation)

import Components.Menu exposing (menu)
import Components.MenuItem exposing (menuItem)
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Material.Icons as Filled
import Types exposing (Menu(..), Model, Msg(..))


navigation : Model -> Html Msg
navigation model =
    Html.div
        [ style "width" (String.fromInt model.appInfo.drawerWidth ++ "px")
        , style "height" "100vh"
        , style "background" "#363636"
        , style "position" "fixed"
        , style "top" "0"
        , style "left" "0"
        , style "box-sizing" "border-box"
        , style "padding" "24px"
        ]
        [ Typography.header model.palette model.appInfo.name
        , menu
            [ menuItem model.palette [ onClick (Navigate SortMenu) ] Filled.sort "Sortieralgorithmen"
            ]
        ]

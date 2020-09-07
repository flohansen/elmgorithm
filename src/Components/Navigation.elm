module Components.Navigation exposing (navigation)

import Color
import Components.Menu exposing (menu)
import Components.MenuItem exposing (menuItem)
import Components.Typography as Typography
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Material.Icons as Filled
import Model exposing (Model)
import Types exposing (Menu(..), Msg(..))


navigation : Model -> Html Msg
navigation model =
    Html.div
        [ style "width" (String.fromInt model.appInfo.drawerWidth ++ "px")
        , style "height" "100vh"
        , style "background" (Color.toCssString model.palette.backgroundCard)
        , style "position" "fixed"
        , style "top" "0"
        , style "left" "0"
        , style "box-sizing" "border-box"
        , style "padding" "24px"
        ]
        [ Typography.cardHeader model.palette model.title
        , menu
            [ menuItem model.palette [ onClick (Navigate SortMenu) ] Filled.sort "Sort algorithms"
            ]
        ]

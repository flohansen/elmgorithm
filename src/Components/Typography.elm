module Components.Typography exposing (body, button, caption, header, label, subheader)

import Html exposing (Html, p, text)
import Html.Attributes exposing (style)


classTypo : List (Html.Attribute msg)
classTypo =
    [ style "padding" "0"
    , style "margin" "0"
    , style "font-family" "Arial"
    ]


classTypoHeader : List (Html.Attribute msg)
classTypoHeader =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "20px"
           , style "color" "#ffffff"
           ]


classTypoBody : List (Html.Attribute msg)
classTypoBody =
    classTypo
        ++ [ style "font-weight" "400"
           , style "font-size" "16px"
           , style "color" "#ffffff"
           ]


classTypoLabel : List (Html.Attribute msg)
classTypoLabel =
    classTypo
        ++ [ style "flex" "0 1 auto"
           , style "margin-right" "16px"
           , style "font-size" "16px"
           , style "color" "#A7A7A7"
           , style "letter-spacing" "0.04em"
           ]


classTypoButton : List (Html.Attribute msg)
classTypoButton =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "12px"
           , style "letter-spacing" "0.18em"
           , style "text-transform" "uppercase"
           ]


classTypoCaption : List (Html.Attribute msg)
classTypoCaption =
    classTypo
        ++ [ style "font-size" "12px"
           , style "letter-spacing" "0.18em"
           , style "text-transform" "uppercase"
           , style "color" "#fff"
           , style "margin-bottom" "24px"
           ]


classTypoSubheader : List (Html.Attribute msg)
classTypoSubheader =
    classTypo
        ++ [ style "font-size" "14px"
           , style "color" "#A7A7A7"
           , style "margin-right" "8px"
           ]


header : String -> Html msg
header str =
    p classTypoHeader [ text str ]


body : String -> Html msg
body str =
    p classTypoBody [ text str ]


label : String -> Html msg
label str =
    p classTypoLabel [ text str ]


button : String -> Html msg
button str =
    p classTypoButton [ text str ]


caption : String -> Html msg
caption str =
    p classTypoCaption [ text str ]


subheader : String -> Html msg
subheader str =
    p classTypoSubheader [ text str ]

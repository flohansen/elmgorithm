module Components.Typography exposing (body, button, caption, cardHeader, code, header, label, subheader)

import Color
import Html exposing (Html, p, text)
import Html.Attributes exposing (style)
import Palette exposing (Palette)


classTypo : List (Html.Attribute msg)
classTypo =
    [ style "padding" "0"
    , style "margin" "0"
    , style "font-family" "Arial"
    ]


classTypoHeader : Palette -> List (Html.Attribute msg)
classTypoHeader p =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "20px"
           , style "color" (Color.toCssString p.textHighlight)
           ]


classTypoCardHeader : Palette -> List (Html.Attribute msg)
classTypoCardHeader p =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "16px"
           , style "color" (Color.toCssString p.textPrimary)
           ]


classTypoBody : Palette -> List (Html.Attribute msg)
classTypoBody p =
    classTypo
        ++ [ style "font-weight" "400"
           , style "font-size" "14px"
           , style "color" (Color.toCssString p.textSecondary)
           , style "line-height" "1.5em"
           ]


classTypoLabel : Palette -> List (Html.Attribute msg)
classTypoLabel p =
    classTypo
        ++ [ style "flex" "0 1 auto"
           , style "margin-right" "16px"
           , style "font-size" "16px"
           , style "color" (Color.toCssString p.textPrimary)
           , style "letter-spacing" "0.04em"
           ]


classTypoCode : Palette -> List (Html.Attribute msg)
classTypoCode p =
    classTypo
        ++ [ style "flex" "0 1 auto"
           , style "margin-right" "16px"
           , style "font-size" "14px"
           , style "color" (Color.toCssString p.textPrimary)
           , style "letter-spacing" "0.04em"
           , style "font-family" "Courier New"
           ]


classTypoButton : Palette -> List (Html.Attribute msg)
classTypoButton p =
    classTypo
        ++ [ style "font-weight" "700"
           , style "font-size" "12px"
           , style "letter-spacing" "0.18em"
           , style "text-transform" "uppercase"
           ]


classTypoCaption : Palette -> List (Html.Attribute msg)
classTypoCaption p =
    classTypo
        ++ [ style "font-size" "10px"
           , style "letter-spacing" "0.15em"
           , style "text-transform" "uppercase"
           , style "color" (Color.toCssString p.textSecondary)
           ]


classTypoSubheader : Palette -> List (Html.Attribute msg)
classTypoSubheader p =
    classTypo
        ++ [ style "font-size" "14px"
           , style "color" (Color.toCssString p.textSecondary)
           , style "margin-right" "8px"
           ]


header : Palette -> String -> Html msg
header palette str =
    p (classTypoHeader palette) [ text str ]


body : Palette -> String -> Html msg
body palette str =
    p (classTypoBody palette) [ text str ]


label : Palette -> String -> Html msg
label palette str =
    p (classTypoLabel palette) [ text str ]


button : Palette -> String -> Html msg
button palette str =
    p (classTypoButton palette) [ text str ]


caption : Palette -> String -> Html msg
caption palette str =
    p (classTypoCaption palette) [ text str ]


subheader : Palette -> String -> Html msg
subheader palette str =
    p (classTypoSubheader palette) [ text str ]


cardHeader : Palette -> String -> Html msg
cardHeader palette str =
    p (classTypoCardHeader palette) [ text str ]


code : Palette -> String -> Html msg
code palette str =
    p (classTypoCode palette) [ text str ]

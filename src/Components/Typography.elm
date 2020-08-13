module Components.Typography exposing (TypographyType(..), typography)

import Html exposing (Html, p, text)
import Html.Attributes exposing (style)


type TypographyType
    = Header
    | Body
    | Label
    | Button
    | Caption
    | Subheader


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


typography : TypographyType -> String -> Html msg
typography typoType str =
    case typoType of
        Header ->
            p classTypoHeader [ text str ]

        Body ->
            p classTypoBody [ text str ]

        Label ->
            p classTypoLabel [ text str ]

        Button ->
            p classTypoButton [ text str ]

        Caption ->
            p classTypoCaption [ text str ]

        Subheader ->
            p classTypoSubheader [ text str ]

module Palette exposing (Palette, dark, light)

import Color exposing (Color)


type alias Palette =
    { background : Color
    , backgroundCard : Color
    , primary : Color
    , secondary : Color
    , textPrimary : Color
    , textHighlight : Color
    , textSecondary : Color
    }


dark : Palette
dark =
    { background = Color.rgb255 18 18 18
    , backgroundCard = Color.rgb255 54 54 54
    , primary = Color.rgb255 39 39 39
    , secondary = Color.rgb255 220 40 101
    , textPrimary = Color.rgb255 255 255 255
    , textHighlight = Color.rgb255 255 255 255
    , textSecondary = Color.rgb255 167 167 167
    }


light : Palette
light =
    { background = Color.rgb255 255 255 254
    , backgroundCard = Color.rgb255 245 245 245
    , primary = Color.rgb255 9 64 103
    , secondary = Color.rgb255 61 169 252
    , textPrimary = Color.rgb255 9 64 103
    , textHighlight = Color.rgb255 255 255 238
    , textSecondary = Color.rgb255 9 64 103
    }

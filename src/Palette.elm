module Palette exposing (Palette, dark, light)


type alias Palette =
    { background : String
    , backgroundCard : String
    , primary : String
    , secondary : String
    , textPrimary : String
    , textSecondary : String
    }


dark : Palette
dark =
    { background = "#121212"
    , backgroundCard = "#363636"
    , primary = "#272727"
    , secondary = "#dc2865"
    , textPrimary = "#ffffff"
    , textSecondary = "#a7a7a7"
    }


light : Palette
light =
    { background = "#121212"
    , backgroundCard = "#363636"
    , primary = "#272727"
    , secondary = "#dc2865"
    , textPrimary = "#ffffff"
    , textSecondary = "#a7a7a7"
    }

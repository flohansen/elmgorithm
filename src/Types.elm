module Types exposing (..)


type Msg
    = None
    | Navigate Menu


type Menu
    = Sort


type alias AppInfo =
    { name : String
    , drawerWidth : Int
    , drawerSettingsWidth : Int
    , appBarHeight : Int
    , currentMenuSelection : Menu
    }


type alias Model =
    { appInfo : AppInfo
    }

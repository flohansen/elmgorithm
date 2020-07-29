module Types exposing (..)


type Msg
    = None
    | Navigate Menu
    | NewValues (List Float)
    | GenValues
    | ChangeNumItems String
    | Sort


type Menu
    = SortMenu


type alias AppInfo =
    { name : String
    , drawerWidth : Int
    , drawerSettingsWidth : Int
    , appBarHeight : Int
    , currentMenuSelection : Menu
    }


type alias Model =
    { appInfo : AppInfo
    , items : List Float
    , numItems : Int
    }

module Types exposing (..)


type Msg
    = None
    | Navigate Menu
    | NewValues (List Float)
    | GenValues
    | ChangeNumItems String
    | StartAnimation
    | StopAnimation
    | Tick
    | ChangeSortAlgo String


type Menu
    = SortMenu


type AnimationState
    = Running
    | Stopped


type alias AnimationFrame =
    { items : List Item
    , comparisons : Int
    }


type alias SortOutput =
    { items : List Item
    , animation : List AnimationFrame
    }


type alias AppInfo =
    { name : String
    , drawerWidth : Int
    , drawerSettingsWidth : Int
    , appBarHeight : Int
    , currentMenuSelection : Menu
    }


type alias Model =
    { appInfo : AppInfo
    , state : AnimationState
    , items : List Item
    , numItems : Int
    , animationLog : List (List Item)
    , algorithm : List Item -> SortOutput
    , comparisons : Int
    }


type alias Item =
    { value : Float
    , color : String
    , animation : String
    }

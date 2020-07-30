module Types exposing (..)


type SortAlgorithm
    = BubbleSort
    | QuickSort


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
    , items : List Float
    , numItems : Int
    , tick : Int
    , animationLog : List (List Float)
    , sortAlgo : SortAlgorithm
    }

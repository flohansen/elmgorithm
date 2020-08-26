module Types exposing (..)

import Palette exposing (Palette)


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
    | ChangeAnimationSpeed String
    | ShowAlgorithmInfo Bool
    | ToggleTheme


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
    { drawerWidth : Int
    , drawerSettingsWidth : Int
    , appBarHeight : Int
    , currentMenuSelection : Menu
    }


type alias AnimationInfo =
    { speed : Float
    , minSpeed : Float
    , maxSpeed : Float
    , numberFrames : Int
    , animation : List AnimationFrame
    , comparisons : Int
    }


type alias Model =
    { appInfo : AppInfo
    , palette : Palette
    , title : String
    , state : AnimationState
    , items : List Item
    , numItems : Int
    , algorithm : List Item -> SortOutput
    , algorithmType : SortAlgorithm
    , animationInfo : AnimationInfo
    , showAlgorithmInfo : Bool
    }


type SortAlgorithm
    = MergeSort
    | QuickSort
    | BubbleSort
    | InsertionSort


type alias Item =
    { value : Float
    , color : String
    , animation : String
    }

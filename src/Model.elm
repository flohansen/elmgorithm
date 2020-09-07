module Model exposing (Model, default)

import Palette exposing (Palette)
import Sort exposing (mergeSort)
import Types exposing (AnimationInfo, AnimationState(..), AppInfo, Item, Menu(..), SortAlgorithm(..), SortOutput)


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


default : Model
default =
    { appInfo =
        { drawerWidth = 320
        , drawerSettingsWidth = 280
        , appBarHeight = 60
        , currentMenuSelection = SortMenu
        }
    , animationInfo =
        { speed = 16
        , minSpeed = 200
        , maxSpeed = 16
        , numberFrames = 0
        , animation = []
        , comparisons = 0
        }
    , palette = Palette.dark
    , title = "Elmgorithm"
    , state = Stopped
    , items = []
    , numItems = 100
    , algorithm = mergeSort
    , algorithmType = MergeSort
    , showAlgorithmInfo = False
    }

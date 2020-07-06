module Main exposing (..)

import Browser
import Html exposing (Html, div)


type Msg
    = None


type alias AppInfo =
    { name : String
    }


type alias Model =
    { appInfo : AppInfo
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { appInfo = { name = "AlgoNerd" } }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div [] []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }

module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- MODEL

type alias Model =
    { status : String
    }


init : Model
init =
    { status = "Initialer Status"
    }


-- UPDATE

type Msg
    = ChangeStatus


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeStatus ->
            { model | status = "Status geändert" }


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ text model.status
        , button [ onClick ChangeStatus ] [ text "Status ändern" ]
        ]


-- MAIN

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

-- Main.elm

module Main2 exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Home
import Url 



-- MODEL

type alias Model =
    { 
        currentPage : Page,
        key : Nav.Key,
        url : Url.Url
    }

type Page
    = HomePage
    | LoginPage


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( {
        currentPage = LoginPage,
        key = key,
        url = url
    },Cmd.none )


-- UPDATE

type Msg
    = SwitchToHomePage  | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SwitchToHomePage  ->
            ( { model | currentPage = HomePage }, Cmd.none )
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )
                Browser.External href ->
                    ( model, Nav.load href )
        UrlChanged url ->
            case url.fragment of 
                Nothing -> ( { model | url = {url | fragment=Just "start"}} 
                    , Cmd.none
                    )
                _ -> ( { model | url = url }
                    , Cmd.none
                    )


-- VIEW

view : Model -> Browser.Document Msg
view model =
    { title = "GymJournal"
    , body =
        [ viewBody model
        ]
    }
    

viewBody : Model -> Html Msg
viewBody model = div[][button[onClick SwitchToHomePage  ][text "Ich bin eine Navbar"],
                    case model.currentPage of
                        HomePage -> Home.homeView
                        LoginPage -> div[][text "Login"]
                    ]
        



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- MAIN

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
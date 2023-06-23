
port module Home exposing (..)
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Url
import Browser.Navigation as Nav




-- MODEL

type alias Model =
    { 
        currentPage : Page,
        key : Nav.Key,
        url : Url.Url,
        message : String
    }
type Page
    = HomePage
    | LoginPage

-- INIT MODEL

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( {
        currentPage = LoginPage,
        key = key,
        url = url,
        message = "init"
    },Cmd.none )

-- Ports für die Kommunikation mit JS
port authenticate : () -> Cmd msg
port tokenReceived : (String -> msg) -> Sub msg


-- UPDATE

type Msg
    = Authenticate | TokenReceived String  | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        -- Wenn man auf LogIn drückt , ruft das die authenticate Methode auf ? 

        Authenticate ->
            (model, authenticate() )
        -- Hier verarbeiten wir unser Token
        TokenReceived token ->
            let
                updatedModel = { model | message = token }
            in
            (updatedModel, Cmd.none)
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
    { title = "Spotify Klon"
    , body =
        [ homeView model
        ]
    }
homeView : Model -> Html Msg
homeView model = div[][
                    case model.currentPage of
                        HomePage -> div[][text "Hallo Welt"]
                        LoginPage -> div[][text "asdasd"]
                    ]
       


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
subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


port module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- MODEL

type alias Model =
    { isLoggedIn : Bool,
    message : String
    }


-- INIT

init : () -> (Model,Cmd Msg)
init _ =
       ({isLoggedIn = False, message = "init"}, 
        Cmd.none)
    

-- Ports
port authenticate : () -> Cmd msg
port tokenRecieved : (String -> msg) -> Sub msg


-- UPDATE

type Msg
    = Authenticate | TokenRecived String

update : Msg -> Model -> (Model,Cmd Msg)
update msg model =
    case msg of
        Authenticate ->
           ( model, authenticate () )
        TokenRecived name -> ({model | message=name },Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Authenticate ] [ text model.message ]
        , if model.isLoggedIn then
            text "Hallo! Du bist eingeloggt."
          else
            text "Bitte logge dich ein."
        ]


-- MAIN

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

{- 
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
        [ viewBody model
        ]
    }
viewBody : Model -> Html Msg
viewBody model = div[][button[onClick Authenticate  ][text "Login"],
                    case model.currentPage of
                        HomePage -> Home.homeView
                        LoginPage -> div[][text "asd"]
                    ]
       


-- MAIN

main : Program () Model Msg
main =
    Browser.element
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
-}
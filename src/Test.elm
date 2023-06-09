module Test exposing (..)

import Browser
import Html exposing (text, Html, div, h3, ul, li, b, a,p, button)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
--import PasswortAuth exposing (Msg)
import Debug exposing (toString)


main : Program () Model Msg
main =
  Browser.sandbox { init = initModel, update = update, view = view }

-- MODEL 
type alias Model =
    {
        name : String,
        adress : String,
        plz : String,
        country : String,
        phoneNumber : String, 
        email : String,
        website : String,
        lang : Msg,
        langShow : String
    }

initModel : Model
initModel  = {
    name = "Name",adress = "Straße und Hausnummer", plz = "Postleitzahl und Ort", country = "Land",phoneNumber = "Telefonnummer", email ="Email",website = "Webseite", lang = English , langShow = "English"
    }
 
type Msg = Deutsch | English 

-- Update 
update : Msg -> Model -> Model
update msg model =
    case msg of
        Deutsch -> {model |  name = "Name",adress = "Straße und Hausnummer", plz = "Postleitzahl und Ort", country = "Land",phoneNumber = "Telefonnummer", email ="Email",website = "Webseite" , lang = English, langShow = "English"}
        English -> {model |  name = "Name",adress = "Street and house number", plz = "Postal code and location", country = "Country",phoneNumber = "Mobile phone", email ="Email",website = "Website", lang = Deutsch , langShow = "Deutsch"}

view : Model -> Html Msg
view model =
    div[][ul[][
        dataTemp model.name  (text "Hallo"),
        dataTemp model.adress  (text "Hallo"),
        dataTemp model.plz  (text "Hallo"),
        dataTemp model.country  (text "Hallo"),
        dataTemp model.phoneNumber  (text "Hallo"),
        dataTemp model.email  (text "Hallo"),
        dataTemp model.website  (text "Hallo")
         ]
        ,   button[onClick model.lang][text model.langShow]
         ]


dataTemp : String -> Html Msg -> Html Msg -- Wieso Html Msg ? 
dataTemp desc value = li[][
    b[][text (desc ++ " : ")], value
    ]
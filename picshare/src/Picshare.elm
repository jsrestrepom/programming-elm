module Picshare exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)


type alias Model =
    { url : String
    , caption : String
    , liked : Bool
    }


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


initialModel : Model
initialModel =
    Model (baseUrl ++ "1.jpg") "Surfing" False


viewLoveButton : Model -> Html Msg
viewLoveButton model =
    let
        buttonClass =
            if model.liked then
                "fa-heart"

            else
                "fa-heart-o"
    in
    div [ class "like-button" ]
        [ i
            [ class "fa fa-2x"
            , class buttonClass
            , onClick ToggleLike
            ]
            []
        ]


viewDetailedPhoto : Model -> Html Msg
viewDetailedPhoto model =
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ viewLoveButton model
            , h2 [ class "caption" ] [ text model.caption ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare-25" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto model
            , viewDetailedPhoto { model | url = baseUrl ++ "2.jpg", caption = "The Fox" }
            , viewDetailedPhoto { model | url = baseUrl ++ "3.jpg", caption = "Evening" }
            ]
        ]


type Msg
    = ToggleLike


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleLike ->
            { model | liked = not model.liked }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }

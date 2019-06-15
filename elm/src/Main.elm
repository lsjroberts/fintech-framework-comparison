module Main exposing (Model, Msg(..), init, main, update, view)

import Api.Object.PercentNotional as PercentNotional
import Api.Object.Summary as Summary
import Api.Query as Query
import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html
import Html.Attributes
import Http
import Maybe.Extra
import RemoteData exposing (RemoteData)
import Url
import Url.Parser as Parser exposing ((</>), Parser, custom, fragment, map, oneOf, s, top)



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }



---- MODEL ----


type alias Model =
    { key : Nav.Key
    , page : Page
    , summary : RemoteData (Graphql.Http.RawError () Http.Error) Summary
    }


type Page
    = NotFound
    | SummaryPage
    | ForexPage


init : Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init url key =
    changeUrlTo url
        { key = key
        , page = NotFound
        , summary = RemoteData.NotAsked
        }



---- GRAPHQL ----


type alias Summary =
    { totalAssets : Float
    , liquidity : PercentNotional
    , positions : PercentNotional
    , pnl : PercentNotional
    }


type alias PercentNotional =
    { percent : Float
    , notional : Float
    }


query : SelectionSet decodeTo RootQuery -> (RemoteData (Graphql.Http.RawError () Http.Error) decodeTo -> Msg) -> Cmd Msg
query queryConstructor msg =
    queryConstructor
        |> Graphql.Http.queryRequest "http://localhost:4000/api"
        |> Graphql.Http.send
            (Graphql.Http.parseableErrorAsSuccess
                >> Graphql.Http.withSimpleHttpError
                >> RemoteData.fromResult
                >> msg
            )


querySummary : SelectionSet Summary RootQuery
querySummary =
    Query.summary summarySelection


summarySelection =
    SelectionSet.map4 Summary
        Summary.totalAssets
        (Summary.liquidity percentNotional)
        (Summary.positions percentNotional)
        (Summary.pnl percentNotional)


percentNotional =
    SelectionSet.map2 PercentNotional PercentNotional.percent PercentNotional.notional



---- UPDATE ----


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotSummary (RemoteData (Graphql.Http.RawError () Http.Error) Summary)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSummary summary ->
            ( { model | summary = summary }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            changeUrlTo url model



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    case model.page of
        NotFound ->
            viewContainer model.page { title = Just "Not Found", child = text "Not Found" }

        SummaryPage ->
            viewContainer model.page
                { title = Nothing
                , child = viewResponse model.summary (\summary -> viewSummary summary)
                }

        ForexPage ->
            viewContainer model.page
                { title = Nothing
                , child = el [] (text "forex")
                }


viewContainer page { title, child } =
    { title = Maybe.Extra.unwrap "FinTech Elm" (\t -> t ++ " - " ++ "FinTech Elm") title
    , body =
        [ layout
            [ height fill
            , htmlAttribute
                (Html.Attributes.style
                    "background-image"
                    "radial-gradient(circle at 30px 30px, #ffffff, #f7f7f7)"
                )
            , Font.color (rgb255 51 51 51)
            , Font.size 14
            ]
          <|
            column [ spacing 4, height fill, width fill ]
                [ column [ width fill ] [ header, navigation page ], child ]
        ]
    }


viewSummary : Summary -> Element Msg
viewSummary summary =
    let
        label t =
            el [ Font.color (rgb255 87 92 103) ] (text t)

        asset format labelText value =
            column [ spacing 4 ]
                [ el [ Font.size 28 ] (formatValue { format = format, value = value })
                , label labelText
                ]
    in
    column [ spacing 4, width fill ]
        [ darkCard <| el [ Font.size 28, Region.heading 2 ] (text "My Portfolio")
        , card <|
            column [ spacing 18 ]
                [ label "Assets"
                , asset Notional "total assets" summary.totalAssets
                , asset Percent "liquidity" summary.liquidity.percent
                , asset Percent "positions" summary.positions.percent
                ]
        , card <|
            column [ spacing 18 ]
                [ label "Profit & Loss"
                , asset Percent "one day" summary.pnl.percent
                ]
        ]


header =
    el
        [ paddingEach { top = 24, right = 16, bottom = 20, left = 16 }
        , width fill
        , Background.color (rgb255 55 214 147)
        , Font.color (rgb 1 1 1)
        , Font.family [ Font.typeface "Merriweather", Font.serif ]
        , Font.size 14
        , Region.heading 1
        ]
        (text "FinTech Co.")


navigation page =
    let
        linkStyles active =
            [ paddingXY 12 15
            , width fill
            , Background.color
                (if active then
                    rgb255 44 230 152

                 else
                    rgba 0 0 0 0
                )
            , Font.bold
            , Font.center
            , Font.color
                (if active then
                    rgb255 247 247 247

                 else
                    rgb255 56 62 75
                )
            , htmlAttribute
                (Html.Attributes.style
                    "transition"
                    "background-color ease-out 0.1s, color ease-out 0.1s"
                )
            , mouseOver
                (if not active then
                    [ Background.color (rgba 0 0 0 0.1) ]

                 else
                    []
                )
            ]
    in
    row [ width fill, Background.color (rgb255 223 226 235), Font.size 16, Region.navigation ]
        [ link (linkStyles (page == SummaryPage)) { url = "/", label = text "Summary" }
        , link (linkStyles False) { url = "/securities", label = text "Securities" }
        , link (linkStyles False) { url = "/positions", label = text "Positions" }
        , link (linkStyles (page == ForexPage)) { url = "/forex", label = text "Forex" }
        ]


card =
    el
        [ padding 28
        , width fill
        , Background.color (rgb255 223 226 235)
        , Font.color (rgb255 56 62 75)
        ]


darkCard =
    el
        [ padding 28
        , width fill
        , Background.color (rgb255 56 62 75)
        , Font.color (rgb 1 1 1)
        ]


type Format
    = Percent
    | Notional


formatValue : { format : Format, value : Float } -> Element Msg
formatValue { format, value } =
    let
        ( normalised, units ) =
            case format of
                Percent ->
                    ( value * 100, "%" )

                Notional ->
                    ( value / 1000000, "M" )

        points =
            "2"
    in
    html <|
        Html.node "format-value"
            [ Html.Attributes.attribute "units" units
            , Html.Attributes.attribute "decimalPoints" points
            , Html.Attributes.attribute "value"
                (String.fromFloat normalised)
            ]
            []


viewResponse : RemoteData e a -> (a -> Element Msg) -> Element Msg
viewResponse response success =
    case response of
        RemoteData.Loading ->
            viewLoading

        RemoteData.Success result ->
            success result

        RemoteData.Failure error ->
            text "error"

        RemoteData.NotAsked ->
            text "not asked"


viewLoading =
    el [ centerX, centerY, Font.size 56 ] <| text "..."



--- ROUTER ---


changeUrlTo url model =
    let
        parser =
            oneOf
                [ route top (routeSummary model)
                , route (s "forex") (routeForex model)
                ]
    in
    case Parser.parse parser url of
        Just answer ->
            answer

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


route parser handler =
    Parser.map handler parser


routeSummary model =
    case model.summary of
        RemoteData.Success _ ->
            ( { model | page = SummaryPage }, Cmd.none )

        _ ->
            ( { model | page = SummaryPage, summary = RemoteData.Loading }
            , query querySummary GotSummary
            )


routeForex model =
    ( { model | page = ForexPage }
    , Cmd.none
    )

-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.Summary exposing (liquidity, pnl, positions, totalAssets)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


liquidity : SelectionSet decodesTo Api.Object.PercentNotional -> SelectionSet decodesTo Api.Object.Summary
liquidity object_ =
    Object.selectionForCompositeField "liquidity" [] object_ identity


pnl : SelectionSet decodesTo Api.Object.PercentNotional -> SelectionSet decodesTo Api.Object.Summary
pnl object_ =
    Object.selectionForCompositeField "pnl" [] object_ identity


positions : SelectionSet decodesTo Api.Object.PercentNotional -> SelectionSet decodesTo Api.Object.Summary
positions object_ =
    Object.selectionForCompositeField "positions" [] object_ identity


totalAssets : SelectionSet Float Api.Object.Summary
totalAssets =
    Object.selectionForField "Float" "totalAssets" [] Decode.float

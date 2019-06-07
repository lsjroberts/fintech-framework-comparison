import { gql } from "apollo-boost";

export const FX_PAIRS = gql`
  fxPairs {
    value
  }
`;

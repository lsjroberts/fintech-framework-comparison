defmodule ServerWeb.SummaryResolver do
  def summary(_root, _args, _info) do
    total = 1_315_226_839
    liquidity = 0.1754
    positions = 1 - liquidity
    pnl = 0.0137

    {:ok,
     %{
       total_assets: total,
       liquidity: %{percent: liquidity, notional: liquidity * total},
       positions: %{percent: positions, notional: positions * total},
       pnl: %{percent: pnl, notional: total * pnl}
     }}
  end
end

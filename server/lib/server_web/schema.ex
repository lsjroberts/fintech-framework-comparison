defmodule ServerWeb.Schema do
  use Absinthe.Schema

  alias ServerWeb.ForexResolver
  alias ServerWeb.SummaryResolver

  object(:rates) do
    field(:usd, :float)
    field(:jpy, :float)
    field(:gbp, :float)
    field(:eur, :float)
  end

  object(:summary) do
    field(:total_assets, non_null(:float))
    field(:liquidity, non_null(:percent_notional))
    field(:positions, non_null(:percent_notional))
    field(:pnl, non_null(:percent_notional))
  end

  object(:percent_notional) do
    field(:percent, non_null(:float))
    field(:notional, non_null(:float))
  end

  query do
    field(:exchange_rates, non_null(:rates)) do
      resolve(&ForexResolver.rates/3)
    end

    field(:summary, non_null(:summary)) do
      resolve(&SummaryResolver.summary/3)
    end
  end
end

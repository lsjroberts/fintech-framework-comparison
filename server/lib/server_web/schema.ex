defmodule ServerWeb.Schema do
  use Absinthe.Schema

  alias ServerWeb.ForexResolver

  object(:rates) do
    field(:usd, :float)
    field(:jpy, :float)
    field(:gbp, :float)
    field(:eur, :float)
  end

  query do
    field(:exchange_rates, non_null(:rates)) do
      resolve(&ForexResolver.rates/3)
    end
  end
end

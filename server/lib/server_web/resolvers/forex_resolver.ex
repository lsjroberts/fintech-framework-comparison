defmodule ServerWeb.ForexResolver do
  @expected_body ~w(
    base
    date
    rates
  )

  def rates(_root, _args, _info) do
    case HTTPoison.get("https://api.exchangeratesapi.io/latest") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok,
         body
         |> Jason.decode!()
         |> Map.take(@expected_body)
         |> (fn m ->
               #  %{
               #    base: m["base"],
               #    date: m["date"],
               #    rates: for({key, val} <- m["rates"], into: %{}, do: {String.to_atom(key), val})
               #  }
               for(
                 {key, val} <- m["rates"],
                 into: %{},
                 do: {String.to_atom(String.downcase(key)), val}
               )
             end).()}

      # |> Map.get(:rates)

      # |> Map.take(@expected_body)
      # |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)

      _ ->
        {:error, "Could not request exchange rates"}
    end
  end
end

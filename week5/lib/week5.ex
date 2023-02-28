defmodule Week5 do
  require HTTPoison
  require Floki

  def get_quotes do
    case HTTPoison.get("https://quotes.toscrape.com/") do
      {:ok, %HTTPoison.Response{body: body}} ->
        Floki.find(body, "div.quote")
        |> Enum.map(&parse_quote/1)
      {:error, reason} ->
        IO.puts "Failed to fetch quotes: #{inspect(reason)}"
        []
    end
  end

  defp parse_quote(div) do
    %{
      quote: div |> Floki.find("span.text") |> Floki.text(),
      author: div |> Floki.find("small.author") |> Floki.text(),
      tags: div |> Floki.find("div.tags a.tag") |> Enum.map(&Floki.text/1)
    }
  end

  def write_quotes_to_json() do
    case File.write("quotes.json", Jason.encode!(get_quotes())) do
      :ok -> IO.puts "Quotes written to quotes.json"
      {:error, reason} -> IO.puts "Failed to write quotes: #{inspect(reason)}"
    end
  end
end

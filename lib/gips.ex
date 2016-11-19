defmodule Gips.CLI do

    @moduledoc """
    GHOST INSPECTOR POST SUBDOMAIN UTILITY
    - where _subdomain_ is the name of the variable
    in ghost inspector's admin interface
    """

    @doc "Get the last line of the vagrant file stdout text file"
    def parse_vagrant_share_url(file) do
        File.read!(file)
         |> String.split("\n")
         |> Enum.filter(&String.length(&1) > 0)
         |> List.last
    end

    defp parse_args(args) do
         {_, word, _} = args
                         |> OptionParser.parse(switches: [upcase: :boolean])
         List.to_string(word)
    end

    defp just_the_url("==> default: URL: " <> url), do: url

    def main(args \\ []) do
        args
        |> parse_args
        |> parse_vagrant_share_url
        |> just_the_url
        |> IO.puts
    end

end

defmodule Gips.CLI do

    @moduledoc """
    GHOST INSPECTOR POST SUBDOMAIN UTILITY
    - where _subdomain_ is the name of the variable
    in ghost inspector's admin interface
    """
    # List of suites as constants
    @homepage "582f46a850dd93ae23078487"

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

    defp just_the_id("http://" <> url) do
      url
      |> String.split(".")
      |> List.first
    end

    defp set_url_in_ghost_inspector(url) do
      response = HTTPotion.get("https://api.ghostinspector.com/v1/suites/582f46a850dd93ae23078487/execute/?apiKey=#{System.get_env("GHOST_INSPECTOR_API_KEY")}&subdomain=#{url}", [timeout: 10_000])
      response
    end

    def main(args \\ []) do
        args
        |> parse_args
        |> parse_vagrant_share_url
        |> just_the_url
        |> just_the_id
#        |> IO.puts
        |> set_url_in_ghost_inspector
    end

end

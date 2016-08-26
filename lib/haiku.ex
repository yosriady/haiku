require IEx;

defmodule Haiku do
    @moduledoc """
        Generates memorable names similar to Xaddress or Heroku.

        You can configure Haiku to use custom words and functions in your config/config.exs:

        config :haiku,
            delimiter: '.',
            range: 9999,
            adjectives: ~w(autumn hidden bitter misty},
            nouns: ~w(meadow sun glade bird}
            reducer_module: Haiku.Custom
            reducer_function: :custom_reduce

        Note that reducer_function receives a list of args with the
        format: [delimiter, adjective, noun, number].
    """

    @delimiter Application.get_env(:haiku, :delimiter)
    @range Application.get_env(:haiku, :range)
    @adjectives Application.get_env(:haiku, :adjectives)
    @nouns Application.get_env(:haiku, :nouns)
    @reducer_module Application.get_env(:haiku, :reducer_module)
    @reducer_function Application.get_env(:haiku, :reducer_function)

    @type build_args :: keyword()

    @doc """
        Returns a new haiku-formatted name.

        iex> Haiku.build
        "quiet-morning-5933"

        iex> Haiku.build(delimiter: '.')
        "quiet.morning.5933"
    """
    @spec build(build_args) :: String.t
    def build, do: _build()
    def build(delimiter: delimiter), do: _build(delimiter)
    def build(range: range), do: _build(@delimiter, range)
    def build(delimiter: delimiter, range: range), do:  _build(delimiter, range)

    defp _build(delimiter \\ @delimiter,
                range \\ @range) do
        adjective = Enum.random(@adjectives)
        noun = Enum.random(@nouns)
        number = if range > 0, do: random(range)
        _reduce(delimiter, adjective, noun, number)
    end

    # Reduces arguments to a single string
    defp _reduce(delimiter, adjective, noun, number) do
        if @reducer_module && @reducer_function do
            apply(@reducer_module, @reducer_function, [delimiter, adjective, noun, number])
        else
            "#{adjective}#{delimiter}#{noun}#{if number, do: delimiter}#{number}"
        end

    end

    # Generates a random number with range from 0 to n
    defp random(n) do
        :rand.uniform(n)
    end
end

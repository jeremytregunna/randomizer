defmodule Randomizer do
  @moduledoc """
  Random string generator
  """

  @letters "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @numbers "0123456789"

  @typedoc """
  Defines random-string types

  * `:all` - random string of both letters and numbers
  * `:alpha` - random string of letters
  * `:downcase` - random string of lowercase, non-numeric characters
  * `:numeric` - random string of numbers
  * `:upcase` - random string of uppercase, non-numeric characters

  """
  @type type() :: :all | :alpha | :downcase | :numeric | :upcase

  @doc """
  Generates a string based on random characters of a given length.

  Raises an error when passed a non-supported type

  ## Examples

      iex> Randomizer.generate!(20)
      "PEeAPSFmEIxJDVeN8ioH"

      iex> Randomizer.generate!(15, :alpha)
      "PEbDWKRCKJVWkfp"

      iex> Randomizer.generate!(30, :downcase)
      "nqvvrbvkhciwzfbcocysvbdiyrcqyd"

      iex> Randomizer.generate!(10, :numeric)
      "7721725515"

      iex> Randomizer.generate!(25, :upcase)
      "CZAIDPFTRZNGNKETOZCJNUCRUTXTYX"
  """
  @spec generate!(pos_integer(), type()) :: String.t()
  def generate!(length, type \\ :all) do
    type
    |> get_characters!()
    |> String.split("", trim: true)
    |> (&do_generate(length, &1)).()
  end

  @doc """
  Generates a random string of words

  ## Options

  * `:dictionary` - Path to an alternative dictionary file

  You can also put this into your application config.

  ## Example

      # config/config.exs
      use Config
      config :randomizer, dictionary: "/usr/share/dict/words"

      # iex
      iex> Randomizer.words!(3)
      "relates mine incomplete"
  """
  def words!(length, opts \\ []) do
    opts
    |> Keyword.get(:dictionary, Application.get_env(:randomizer, :dictionary))
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.take_random(length)
    |> Enum.join(" ")
  end

  # Private

  defp do_generate(length, characters) do
    length
    |> get_range()
    |> Enum.reduce([], fn _, acc -> [Enum.random(characters) | acc] end)
    |> Enum.join("")
  end

  defp get_characters!(:all), do: @letters <> String.downcase(@letters) <> @numbers
  defp get_characters!(:alpha), do: @letters <> String.downcase(@letters)
  defp get_characters!(:downcase), do: String.downcase(@letters)
  defp get_characters!(:numeric), do: @numbers
  defp get_characters!(:upcase), do: @letters
  defp get_characters!(type), do: raise("Unsupported Randomizer type. Received #{inspect(type)}")

  defp get_range(length) when length > 1, do: 1..length
  defp get_range(_length), do: [1]
end

defmodule Randomizer do
  @moduledoc """
  Random string generator
  """

  @letters "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @numbers "0123456789"

  @doc """
  Generates a string based on random characters of a given length.

  Raises an error when passed a non-supported type

  ## Options

  * `:all` - random string letters and numbers
  * `:alpha` - random string of letters
  * `:downcase` - random string of lowercase non-numeric characters
  * `:numeric` - numeric random string
  * `:upcase` - upper case non-numeric random string

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
  def generate!(length, type \\ :all) do
    type
    |> get_characters!()
    |> String.split("", trim: true)
    |> (&do_generate(length, &1)).()
  end

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
  defp get_characters!(type), do: raise("Unsupoorted Randomizer type. Received #{inspect(type)}")

  defp get_range(length) when length > 1, do: 1..length
  defp get_range(_length), do: [1]
end

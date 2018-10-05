defmodule RandomizerTest do
  use ExUnit.Case
  use ExUnitProperties

  defp do_test(type, size, regex) do
    random = Randomizer.generate!(size, type)
    assert size == String.length(random)
    assert String.match?(random, regex)
  end

  property "generates random strings" do
    check all list <- list_of(positive_integer()),
              list != [],
              size <- member_of(list),
              do: do_test(:all, size, ~r/[A-Za-z0-9]/)
  end

  property "generates random numbers" do
    check all list <- list_of(positive_integer()),
              list != [],
              size <- member_of(list),
              do: do_test(:numeric, size, ~r/[0-9]/)
  end

  property "generates random uppercase" do
    check all list <- list_of(positive_integer()),
              list != [],
              size <- member_of(list),
              do: do_test(:upcase, size, ~r/[A-Z]/)
  end

  property "generates random lowercase" do
    check all list <- list_of(positive_integer()),
              list != [],
              size <- member_of(list),
              do: do_test(:downcase, size, ~r/[a-z]/)
  end

  property "generates random alphabets only" do
    check all list <- list_of(positive_integer()),
              list != [],
              size <- member_of(list),
              do: do_test(:alpha, size, ~r/[A-Za-z]/)
  end
end

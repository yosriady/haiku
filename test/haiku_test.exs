defmodule HaikuTest do
  use ExUnit.Case, async: true

  test "returns a correctly formatted name" do
      haiku = Haiku.build
      assert String.match?(haiku, ~r/\A\w+-\w+-\d{1,4}\z/)
  end

  test "allows overriding delimiter" do
      haiku = Haiku.build(delimiter: ".")
      assert String.match?(haiku, ~r/\A\w+.\w+.\d{1,4}\z/)
  end

  test "allows overriding range" do
      haiku = Haiku.build(range: 7)
      assert String.match?(haiku, ~r/\A\w+.\w+.\d{1,7}\z/)
  end

  test "allows disabling range" do
      haiku = Haiku.build(range: 0)
      assert String.match?(haiku, ~r/\A\w+.\w+\z/)
  end

  test "allows overriding of both delimiter and range" do
      haiku = Haiku.build(delimiter: "|", range: 5)
      assert String.match?(haiku, ~r/\A\w+|\w+|\d{1,5}\z/)
  end
end

defmodule DotmapTest do
  use ExUnit.Case
  doctest Dotmap

  test "contract!/1 converts a single level map to an array of tuples" do
    map = %{"a" => 1, "b" => 2}
    assert Dotmap.contract!(map) == [{"a", 1}, {"b", 2}]
  end

  test "contract!/1 converts a multi level map to an array of tuples" do
    map = %{"a" => 1, "b" => 2, "c" => %{"d" => 3, "e" => 4}}
    assert Dotmap.contract!(map) == [{"a", 1}, {"b", 2}, {"c.d", 3}, {"c.e", 4}]
  end

  test "contract!/1 throws an error if a key is not a string" do
    map = %{1 => 1}

    assert_raise ArgumentError, "Key must be a string", fn ->
      Dotmap.contract!(map)
    end
  end

  test "expand!/1 converts an array of tuples to a single level map" do
    list = [{"a", 1}, {"b", 2}]
    assert Dotmap.expand!(list) == %{"a" => 1, "b" => 2}
  end
end

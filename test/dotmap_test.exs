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

  test "contract!/1 throws an error if the argument is not a map" do
    assert_raise ArgumentError, "Argument must be a map", fn ->
      Dotmap.contract!(1)
    end
  end

  test "contract/1 returns a success tuple" do
    map = %{"a" => 1, "b" => 2}
    assert Dotmap.contract(map) == {:ok, [{"a", 1}, {"b", 2}]}
  end

  test "contract/1 returns an error tuple if a key is not a string" do
    map = %{1 => 1}
    assert Dotmap.contract(map) == {:error, "Key must be a string"}
  end

  test "contract/1 throws an error if the argument is not a map" do
    assert_raise ArgumentError, "Argument must be a map", fn ->
      Dotmap.contract(1)
    end
  end

  test "expand!/1 converts an array of tuples to a single level map" do
    list = [{"a", 1}, {"b", 2}]
    assert Dotmap.expand!(list) == %{"a" => 1, "b" => 2}
  end

  test "expand!/1 converts an array of tuples to a multi level map" do
    list = [{"a", 1}, {"b", 2}, {"c.d", 3}, {"c.e", 4}]
    assert Dotmap.expand!(list) == %{"a" => 1, "b" => 2, "c" => %{"d" => 3, "e" => 4}}
  end

  test "expand!/1 throws an error if a key is not a string" do
    list = [{1, 1}]

    assert_raise ArgumentError, "Key must be a string", fn ->
      Dotmap.expand!(list)
    end
  end

  test "expand/1 returns a success tuple" do
    list = [{"a", 1}, {"b", 2}]
    assert Dotmap.expand(list) == {:ok, %{"a" => 1, "b" => 2}}
  end

  test "expand/1 returns an error tuple if a key is not a string" do
    list = [{1, 1}]
    assert Dotmap.expand(list) == {:error, "Key must be a string"}
  end

  test "place/3 adds a key value pair to a flat map" do
    map = %{"a" => 1}
    assert Dotmap.place(map, "b", 2) == %{"a" => 1, "b" => 2}
  end

  test "place/3 adds a key value pair to a nested map" do
    map = %{"a" => 1, "b" => 2, "c" => %{"d" => 3, "e" => 4}}

    assert Dotmap.place(map, "c.f", 5) == %{
             "a" => 1,
             "b" => 2,
             "c" => %{"d" => 3, "e" => 4, "f" => 5}
           }
  end
end

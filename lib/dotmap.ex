defmodule Dotmap do
  @moduledoc """
  A module for handling conversions of maps into dot notation and vice versa.
  """

  @doc """
  Converts a map into an array of tuples.

  ## Examples

      iex> Dotmap.contract!(%{"a" => 1, "b" => 2})
      [{"a", 1}, {"b", 2}]

      iex> Dotmap.contract!(%{"a" => 1, "b" => 2, "c" => %{"d" => 3, "e" => 4}})
      [{"a", 1}, {"b", 2}, {"c.d", 3}, {"c.e", 4}]
  """

  def contract!(map) do
    do_contract(map)
  end

  @doc """
  Converts an array of tuples into a map.

  ## Examples

      iex> Dotmap.expand!([{"a", 1}, {"b", 2}])
      %{"a" => 1, "b" => 2}

      iex> Dotmap.expand!([{"a", 1}, {"b", 2}, {"c.d", 3}, {"c.e", 4}])
      %{"a" => 1, "b" => 2, "c" => %{"d" => 3, "e" => 4}}
  """
  def expand!(list) do
    Enum.reduce(list, %{}, fn {k, v}, acc ->
      if !is_binary(k) do
        raise ArgumentError, "Key must be a string"
      end

      place(acc, k, v)
    end)
  end

  defp do_contract(map, base_key \\ "") do
    Enum.reduce(map, [], fn {k, v}, acc ->
      if !is_binary(k) do
        raise ArgumentError, "Key must be a string"
      end

      key =
        case base_key do
          "" -> k
          _ -> "#{base_key}.#{k}"
        end

      case v do
        v when is_map(v) -> acc ++ do_contract(v, key)
        _ -> acc ++ [{key, v}]
      end
    end)
  end

  defp place(map, key, value) do
    keys = String.split(key, ".", parts: 2)

    if length(keys) == 1 do
      Map.put(map, key, value)
    else
      h = hd(keys)
      t = tl(keys) |> hd()

      if Map.has_key?(map, h) do
        Map.put(map, h, place(Map.get(map, h), t, value))
      else
        Map.put(map, h, place(%{}, t, value))
      end
    end
  end
end

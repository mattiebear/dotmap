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

  def expand!(list) do
    Enum.reduce(list, %{}, fn {k, v}, acc ->
      keys = String.split(k, ".")

      if length(keys) == 1 do
        Map.put(acc, k, v)
      else
        # If the key is a compound key, split it into parts
        # If the first part of the key is not in the map, create a new map
        # If the first part of the key is in the map, add the value to the map
        # If the first part of the key is in the map and is a map, recurse
        # If the first part of the key is in the map and is not a map, raise an error
      end
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

  defp do_expand(list) do
  end
end

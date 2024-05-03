# Dotmap

Dotmap allows you to convert between nested maps and flat lists using dot notation.

![CI Status](https://github.com/mattiebear/dotmap/actions/workflows/verify.yml/badge.svg)

## Installation

Add `dotmap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dotmap, "~> 0.1.0"}
  ]
end
```

## Usage

Convert a map into a flat list using `contract!/1`. It generates a tuple list of key value pairs. Nested keys are joined using a `.`. For example, the map `%{"a" => %{"b" => 1}}` will contract into the list `[{"a.b" => 1}]`.

```elixir
Dotmap.contract!(%{"a" => %{"b" => 1}})

# [{"a.b" => 1}]
```

To restore maps from the key/value list, use `expand!/1`.

```elixir
Dotmap.expand!([{"a.b" => 1}])

# %{"a" => %{"b" => 1}}
```

Keys must be strings. If you attempt either function using a non-string key an `ArgumentError` will be raised.

## Additional Notes

Online documentation can be found at [Hexdocs](https://hexdocs.pm/dotmap)

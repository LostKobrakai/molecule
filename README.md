# Molecule

[![Hex pm](https://img.shields.io/hexpm/v/molecule)](https://hex.pm/packages/molecule)
[![License](https://img.shields.io/hexpm/l/molecule)](https://github.com/LostKobrakai/molecule/blob/master/LICENSE.md)

<!-- MDOC !-->
Rendering of components with named slots.

`Molecule` allows rendering of components with named slots in phoenix or other eex based templating (needs `render/2`/`render/3` functions like phoenix views though).

## Example

```elixir
<%= component Module, "template.ext", assigns fo %>
  <% slot :name do %>
    Contents for named slot
  <% end %>
  Body contents <%= dynamic_content %>
<% end %>
```

This will essentially call (disregarding some whitespace).

```elixir
render(Module, "template.ext", Map.put(assigns, :slots, %{
  name: "Contents for named slot",
  body: "Body contents …"
})
```

The called template can then do whatever it needs to do with those slots.

## Slot Function

Besides the `do/end` block format slots also support a function format:

```
<% slot :name, fn data -> %>
  Contents for named slot
<% end %>
```

Where the component template can pass data to the slot: `@slots.name.(data)`.

<!-- MDOC !-->

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `molecule` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:molecule, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/molecule](https://hexdocs.pm/molecule).


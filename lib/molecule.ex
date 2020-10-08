defmodule Molecule do
  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @spec component(
          view :: Macro.t(),
          template :: Macro.t(),
          assigns :: Macro.t(),
          block :: Macro.t()
        ) :: Macro.t()
  defmacro component(view, template, assigns, do: {:__block__, _, list})
           when is_list(list) and is_map(assigns) do
    quote do
      render(
        unquote(view),
        unquote(template),
        Map.put(
          unquote(assigns),
          :slots,
          unquote(map_ast_for_blocks(map_blocks(list)))
        )
      )
    end
  end

  @spec component(
          view_or_template :: Macro.t(),
          template_or_assigns :: Macro.t(),
          block :: Macro.t()
        ) :: Macro.t()

  defmacro component(view, template, do: {:__block__, _, list})
           when is_list(list) and is_binary(template) do
    quote do
      render(
        unquote(view),
        unquote(template),
        %{slots: unquote(map_ast_for_blocks(map_blocks(list)))}
      )
    end
  end

  defmacro component(template, assigns, do: {:__block__, _, list})
           when is_list(list) and is_map(assigns) do
    quote do
      render(
        unquote(template),
        Map.put(
          unquote(assigns),
          :slots,
          unquote(map_ast_for_blocks(map_blocks(list)))
        )
      )
    end
  end

  @spec component(template :: Macro.t(), block :: Macro.t()) :: Macro.t()
  defmacro component(template, do: {:__block__, _, list})
           when is_list(list) and is_binary(template) do
    quote do
      render(
        unquote(template),
        %{slots: unquote(map_ast_for_blocks(map_blocks(list)))}
      )
    end
  end

  defp map_ast_for_blocks(blocks) do
    {:%{}, [], Enum.into(blocks, [])}
  end

  defp map_blocks(list) when is_list(list) do
    Enum.reduce(list, %{body: []}, fn
      {:slot, _, [name, [do: block]]}, acc ->
        Map.put(acc, name, block)

      {:slot, _, [name, fun]}, acc ->
        Map.put(acc, name, fun)

      block, acc ->
        Map.update!(acc, :body, fn cur -> cur ++ [block] end)
    end)
    |> Map.update!(:body, fn list -> {:__block__, [], list} end)
  end
end

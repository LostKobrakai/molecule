defmodule Molecule do
  @moduledoc """
  Documentation for `Molecule`.
  """
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

      block, acc ->
        Map.update!(acc, :body, fn cur -> cur ++ [block] end)
    end)
    |> Map.update!(:body, fn list -> {:__block__, [], list} end)
  end
end

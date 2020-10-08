defmodule MoleculeTest do
  use ExUnit.Case
  doctest Molecule

  defmodule OneView do
    use Phoenix.View, root: "test/templates"
    import Molecule
  end

  test "Works for Phoenix.HTML engine" do
    assert """
           <div>
             <header>    Header 2
           </header>
             Test 2
           2</div>
           """ = Phoenix.View.render_to_string(OneView, "rendered.html", %{})
  end
end

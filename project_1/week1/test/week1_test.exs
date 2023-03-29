defmodule Week1Test do
  use ExUnit.Case
  doctest Week1

  test "greets the world" do
    assert Week1.hello() == :world
  end
end

defmodule HelloLLMTest do
  use ExUnit.Case
  doctest HelloLLM

  test "greets the world" do
    assert HelloLLM.hello() == :world
  end
end

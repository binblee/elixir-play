defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end
end

IO.puts(Geometry.rectangle_area(3,4))

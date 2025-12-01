defmodule UserInfo do
  use Ecto.Schema
  use InstructorLite.Instruction

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:age, :integer)
  end
end

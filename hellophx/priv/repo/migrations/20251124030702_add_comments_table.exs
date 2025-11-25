defmodule Hellophx.Repo.Migrations.AddCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :word_count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end

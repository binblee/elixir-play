defmodule Article do
  use Ecto.Schema
  use InstructorLite.Instruction

  @primary_key false
  embedded_schema do
    field(:response, :string)
  end

  def represent(%__MODULE__{} = item) do
    item.response
  end
end

defmodule Outline do
  use Ecto.Schema
  use InstructorLite.Instruction

  @primary_key false
  embedded_schema do
    field(:outline, {:array, :string})
  end

  def represent(%__MODULE__{} = item) do
    item.outline |> Enum.join("\n")
  end
end

defmodule ArticleBuilder do
  def generate_content(topic) do
    initial_messages = [
      %{role: "user", content: "You are an expert at crafting SEO friendly blog articles"}
    ]

    with {:outline, {:ok, _outline, outline_messages}} <-
           {:outline, create_outline(initial_messages, topic)},
         {:article, {:ok, article, _article_messages}} <-
           {:article, create_article(outline_messages)},
         {:translation, {:ok, translated_article, _translated_messages}} <-
           {:translation, translate_to(article, "chinese")} do
      {article, translated_article}
    else
      {stage, {:error, err}} ->
        IO.puts("Error in stage #{stage}: #{inspect(err)}")
        {:error, {stage, err}}
    end
  end

  def create_outline(messages, topic) do
    messages = messages ++
      [
        %{
          role: "user",
          content: "Please generate an outline of an article about the following topic #{topic}"
        }
      ]
    run_query(messages, Outline)
  end

  def create_article(messages) do
    messages = messages ++
      [
        %{
          role: "user",
          content: "Please generate a full article based on the provided outline"
        }
      ]
    run_query(messages, Article)
  end

  def translate_to(%Article{response: content}, language \\ "spanish") do
    messages = [
      %{
        role: "user",
        content: "You are an expert polyglot translator, that provides article translations. Do not make any changes to the content other than translating it"
      },
      %{
        role: "user",
        content: "Please translate the following article into #{language}:\n\n#{content}"
      }
    ]
    run_query(messages, Article)
  end

  defp run_query(messages, response_model) do
    case InstructorLite.instruct(
           %{
              messages: messages,
              model: "gemini-2.5-flash"
           },
           response_model: response_model,
           adapter: InstructorLite.Adapters.ChatCompletionsCompatible,
           adapter_context: [
            url: "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
            api_key: Application.fetch_env!(:instructor_lite, :gemini_key)
          ]
         ) do
      {:ok, response} ->
        {:ok, response, messages ++ [%{role: "assistant", content: response_model.represent(response)}]}

      {:error, reason} ->
        IO.puts("Error in run_query: #{inspect(reason)}")
        {:error, reason}
    end
  end
end

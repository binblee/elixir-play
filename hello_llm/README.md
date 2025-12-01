# HelloLLM

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hello_llm` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hello_llm, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/hello_llm>.


## InstructorLite test

### Gemini API
```elixir
iex(1)> InstructorLite.instruct(%{
            contents: [
              %{
                role: "user",
                parts: [%{text: "John Doe is forty-two years old"}]
              }
            ]
          },
          response_model: UserInfo,
          json_schema: %{
            type: "object",
            required: [:age, :name],
            properties: %{name: %{type: "string"}, age: %{type: "integer"}},
          },
          adapter: InstructorLite.Adapters.Gemini,
          adapter_context: [
            api_key: Application.fetch_env!(:instructor_lite, :gemini_key)
          ]
        )
{:ok, %UserInfo{name: "John Doe", age: 42}}
```

### Access Gemini using OpenAI endpoint
```elixir
iex(5)> InstructorLite.instruct(
                    %{
                      messages: [
                        %{role: "user", content: "John Doe is forty-two years old"}
                      ],
                      model: "gemini-2.5-flash"
                    },
                    adapter: InstructorLite.Adapters.ChatCompletionsCompatible,
                    response_model: UserInfo,
                    adapter_context: [
                      url: "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
                      api_key: Application.fetch_env!(:instructor_lite, :gemini_key)
                    ]
                  )
{:ok, %UserInfo{name: "John Doe", age: 42}}
```

## Why Elixir/OTP doesn't need an Agent framework: Part 1
https://goto-code.com/why-elixir-otp-doesnt-need-agent-framework-part-1/

### Prompt chaining

```elixir
ArticleBuilder.generate_content("Impact of AI on white collar jobs")
```

### Routing

```elixir
TopicAnalyzer.analyze_topic(:entertainment)
```

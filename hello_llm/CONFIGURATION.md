# Configuration for HelloLLM

To run this application, you need to set your Gemini API key as an environment variable:

```bash
export GEMINI_API_KEY="your_actual_gemini_api_key_here"
```

Alternatively, for development purposes, you can create a `.env` file in the project root:

```bash
echo 'GEMINI_API_KEY="your_actual_gemini_api_key_here"' > .env
```

Then load it before running your application:

```bash
source .env
```

After setting the environment variable, you can run your application with:

```bash
iex -S mix
```
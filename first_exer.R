client <- chat_google_gemini("You are a terse assistant.")
client$chat("What is the capital of France?")
# the client is stateful, so this continues the conversation
client$chat("What is its most famous landmark?")
# While you wait
live_browser(client)
client$chat("What is its most famous street?")

options(httr2_verbosity = 2)
chat <- chat_anthropic("You are a terse assistant.", echo = FALSE)
chat$chat("Tell me a joke about a statistician and a data scientist")
chat$chat("Explain why that's funny")
chat$chat("Make the joke funnier")
chat$chat("Explain why that is funnier")

# tool calling
options(httr2_verbosity = 0)

chat <- chat_anthropic("You're a terse assistant")
chat$chat("What's today's date?")
#> Today is November 24, 2023.

chat$register_tool(tool(
  function() Sys.Date(), 
  "Gets the current date",
  .name = "today"
))
chat$chat("What's today's date?")
chat

chat <- chat_anthropic()
chat$chat("How old is Cher? Explain your working")
chat$register_tool(tool(
  function() Sys.Date(), 
  "Gets the current date",
  .name = "today"
))
chat$chat("How old is Cher? Explain your working")

chat <- chat_anthropic()
chat$register_tool(tool(
  function() Sys.Date(), 
  "Gets the current date",
  .name = "today"
))
chat$chat("How old is Cher? Use the today tool for your calculation. Explain your working")

prompts <- list(
  "I go by Alex. 42 years on this planet and counting.",
  "Pleased to meet you! I'm Jamal, age 27.",
  "They call me Li Wei. Nineteen years young.",
  "Fatima here. Just celebrated my 35th birthday last week.",
  "The name's Robert - 51 years old and proud of it.",
  "Kwame here - just hit the big 5-0 this year."
)
type_person <- type_object(name = type_string(), age = type_number())
chat <- chat_anthropic()
parallel_chat_structured(chat, prompts, type_person)



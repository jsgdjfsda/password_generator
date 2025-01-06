defmodule PasswordGenerator.Words do
  @dict_file "dict/rare_pl.dict"
  @external_resource @dict_file

  @words (case File.read(@dict_file) do
           {:ok, content} ->
             content
             |> String.split("\n")
             |> Enum.filter(&(String.length(&1) > 0))
           {:error, _} ->
             IO.warn("Dictionary file #{@dict_file} not found. Using empty word list.")
             []
         end)

  def generate(options) do
    password =
      options.min_length..options.max_length
      |> Enum.random()
      |> generate_word_list(options)
      |> transform_words(options)
      |> Enum.join(options.separator)

    {password, options}
  end

  defp generate_word_list(word_count, _options) do
    Enum.map(1..word_count, fn _ ->
      @words
      |> Enum.filter(&(String.length(&1) > 2)) # Filter out too short words
      |> Enum.random()
      |> String.trim()
    end)
  end

  defp transform_words(words, options) do
    words
    |> Enum.map(fn word ->
      word = if options.uppercase, do: randomize_case(word), else: word

      if options.numbers do
        word <> Integer.to_string(Enum.random(0..9))
      else
        word
      end
    end)
  end

  defp randomize_case(word) do
    word
    |> String.graphemes()
    |> Enum.map(&random_uppercase/1)
    |> Enum.join()
  end

  defp random_uppercase(char) do
    if :rand.uniform() < 0.5 do
      String.upcase(char)
    else
      String.downcase(char)
    end
  end

end

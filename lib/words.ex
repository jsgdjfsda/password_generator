defmodule PasswordGenerator.Words do
  @words ~w(
    apple banana cherry dolphin elephant falcon giraffe
    hamburger igloo jacket kangaroo lemon monkey notebook
    orange penguin queen rabbit sunset turtle umbrella
    violin whale xylophone yellow zebra
  )

  def generate(options) do
    num_words = Enum.random(2..4)

    password =
      1..num_words
      |> Enum.map(fn _ -> Enum.random(@words) end)
      |> transform_words(options)
      |> Enum.join(options.separator)

    {password, options}
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

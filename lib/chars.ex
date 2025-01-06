defmodule PasswordGenerator.Chars do
  @lowercase_chars ?a..?z |> Enum.to_list()
  @uppercase_chars ?A..?Z |> Enum.to_list()
  @numbers ?0..?9 |> Enum.to_list()
  @symbols ~c"!@#$%^&*()_+-=[]{}|;:,.<>?"

  def generate(options) do
    chars = get_allowed_chars(options)
    length = Enum.random(options.min_length..options.max_length)

    password =
      1..length
      |> Enum.map(fn _ -> Enum.random(chars) end)
      |> List.to_string()

    {password, options}
  end

  defp get_allowed_chars(options) do
    chars = @lowercase_chars

    chars =
      if options.uppercase do
        chars ++ @uppercase_chars
      else
        chars
      end

    chars =
      if options.numbers do
        chars ++ @numbers
      else
        chars
      end

    chars =
      if options.symbols do
        chars ++ @symbols
      else
        chars
      end

    chars
  end
end

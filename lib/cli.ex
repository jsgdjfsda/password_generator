defmodule PasswordGenerator.CLI do
  def main(args) do
    args
    |> parse_args()
    |> generate_password()
    |> handle_generated_password()
  end

  defp parse_args(args) do
    {opts, _, _} =
      OptionParser.parse(args,
        strict: [
          type: :string,
          min_length: :integer,
          max_length: :integer,
          uppercase: :boolean,
          numbers: :boolean,
          symbols: :boolean,
          separator: :string,
          file: :string
        ]
      )

    %{
      type: opts[:type] || "chars",
      min_length: opts[:min_length] || 8,
      max_length: opts[:max_length] || 16,
      uppercase: opts[:uppercase] || false,
      numbers: opts[:numbers] || false,
      symbols: opts[:symbols] || false,
      separator: opts[:separator] || "-",
      file: opts[:file]
    }
  end

  defp generate_password(options) do
    {password, options} =
      case options.type do
        "chars" -> PasswordGenerator.Chars.generate(options)
        "words" -> PasswordGenerator.Words.generate(options)
        _ -> raise "Unsupported password type: #{options.type}"
      end

    {password, options}
  end

  defp handle_generated_password({password, options}) do
    if options.file do
      File.write!(options.file, password)
      IO.puts("Password has been saved to #{options.file}")
    else
      IO.puts(password)
    end
  end
end

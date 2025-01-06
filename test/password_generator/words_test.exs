defmodule PasswordGenerator.WordsTest do
  use ExUnit.Case
  doctest PasswordGenerator.Words

  alias PasswordGenerator.Words

  # Test setup with common options
  setup do
    base_options = %{
      min_length: 2,
      max_length: 4,
      separator: "-",
      uppercase: false,
      numbers: false
    }
    {:ok, options: base_options}
  end

  describe "generate/1" do
    test "generates password within length constraints", %{options: options} do
      {password, _opts} = Words.generate(options)
      words = String.split(password, options.separator)
      assert length(words) >= options.min_length
      assert length(words) <= options.max_length
    end

    test "uses specified separator", %{options: options} do
      options = Map.put(options, :separator, "_")
      {password, _opts} = Words.generate(options)
      assert String.contains?(password, "_")
      refute String.contains?(password, "-")
    end

    test "adds numbers when option is enabled", %{options: options} do
      options = Map.put(options, :numbers, true)
      {password, _opts} = Words.generate(options)

      # Check if at least one word ends with a number
      words = String.split(password, options.separator)
      has_number = Enum.any?(words, fn word ->
        String.last(word) =~ ~r/[0-9]/
      end)

      assert has_number
    end

    test "doesn't add numbers when option is disabled", %{options: options} do
      {password, _opts} = Words.generate(options)
      refute String.match?(password, ~r/[0-9]/)
    end

    test "uses mixed case when uppercase is enabled", %{options: options} do
      options = Map.put(options, :uppercase, true)
      {password, _opts} = Words.generate(options)

      # Check if password contains both uppercase and lowercase letters
      has_upper = String.match?(password, ~r/[A-Z]/)
      has_lower = String.match?(password, ~r/[a-z]/)

      assert has_upper and has_lower
    end

    test "uses only lowercase when uppercase is disabled", %{options: options} do
      {password, _opts} = Words.generate(options)
      refute String.match?(password, ~r/[A-Z]/)
    end

    test "all words are at least 3 characters long", %{options: options} do
      {password, _opts} = Words.generate(options)

      words = String.split(password, options.separator)
      all_valid_length = Enum.all?(words, fn word ->
        # Remove any trailing numbers before checking length
        base_word = String.replace(word, ~r/[0-9]$/, "")
        String.length(base_word) >= 3
      end)

      assert all_valid_length
    end

    test "combines all options together", %{options: options} do
      options = %{options |
        uppercase: true,
        numbers: true,
        separator: "#",
        min_length: 3,
        max_length: 3
      }

      {password, _opts} = Words.generate(options)

      words = String.split(password, "#")
      assert length(words) == 3
      assert String.match?(password, ~r/[A-Z]/)
      assert String.match?(password, ~r/[a-z]/)
      assert String.match?(password, ~r/[0-9]/)
      assert String.contains?(password, "#")
    end

    test "returns original options alongside password" do
      options = %{
        min_length: 2,
        max_length: 2,
        separator: ".",
        uppercase: true,
        numbers: true
      }

      {_password, returned_options} = Words.generate(options)
      assert returned_options == options
    end
  end
end

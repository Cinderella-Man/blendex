defmodule Blendex.Converter do

  def transpile_command({:raw, python_code}) do
    python_code
  end

  def transpile_command(:quit) do
    "quit"
  end

  def transpile_command(command) do
    "#{command.action}(" <>
    stringify_args(command.args) <>
    ")"
  end

  def stringify_args(args \\ []) do
    args
    |> Enum.map(&stringify_arg/1)
    |> Enum.join(", ")
  end

  def stringify_arg({key, val}) when is_list(val) do
    args_list = val
    |> Enum.join(", ")

    "#{key}=(" <> args_list <> ")"
  end

  def stringify_arg({key, False}), do: "#{key}=False"
  def stringify_arg({key, True}), do: "#{key}=True"

  def stringify_arg({key, val}) when is_binary(val) do
    "#{key}='#{val}'"
  end

  def stringify_arg({key, val}) do
    "#{key}=#{val}"
  end
end

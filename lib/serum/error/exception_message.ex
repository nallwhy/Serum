defmodule Serum.Error.ExceptionMessage do
  @moduledoc """
  Defines a struct which contains exception and stacktrace (if any) information.
  """

  @behaviour Serum.Error.Message

  defstruct [:exception, :stacktrace]

  @type t :: %__MODULE__{
          exception: Exception.t(),
          stacktrace: Exception.stacktrace()
        }

  def message([exception, stacktrace]) do
    %__MODULE__{exception: exception, stacktrace: stacktrace}
  end

  defimpl Serum.Error.Format do
    alias Serum.Error.ExceptionMessage

    def format_text(%ExceptionMessage{} = msg, _indent) do
      [
        "an error was raised:\n",
        :red,
        Exception.format_banner(:error, msg.exception),
        [:light_black, ?\n],
        Exception.format_stacktrace(msg.stacktrace),
        :reset
      ]
    end
  end
end

defmodule Verk.Job do
  @moduledoc """
  The Job struct
  """

  @default_max_retry_count Application.get_env(:verk, :max_retry_count, 25)
  @keys [error_message: nil, failed_at: nil, retry_count: 0, queue: nil, class: nil, args: [],
         jid: nil, finished_at: nil, enqueued_at: nil, retried_at: nil, error_backtrace: nil,
         max_retry_count: @default_max_retry_count]

  @derive {Poison.Encoder, only: Keyword.keys(@keys)}
  defstruct [:original_json | @keys]

  @doc """
  Decode the JSON payload storing the original json as part of the struct.
  """
  @spec decode!(binary) :: %__MODULE__{}
  def decode!(payload) do
    job = Poison.decode!(payload, as: %__MODULE__{})
    %Verk.Job{job | original_json: payload}
  end

  def default_max_retry_count do
    @default_max_retry_count
  end
end

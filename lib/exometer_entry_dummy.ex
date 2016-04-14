defmodule Exometer.Entry.Dummy do
  use Exometer.Entry
  @moduledoc """
  This is a dummy drop in module for exometer which doesn't do anything. You
  can use it if you want to do testing of your code without depending on
  actual exometer entries.
  """

  @doc """
  Create a new dummy entry, always returns :dummy
  """
  def new(_, _, _) do
    {:ok, {:dummy}}
  end

  @doc """
  Update the dummy entry (doesn't do anything)
  """
  def update(_, _, _, _), do: :ok

  @doc """
  Get a fake value. Returns -1 for each datapoint
  """
  def get_value(_, _, _, dp) do
    Enum.map(dp, fn(x) -> {x, -1} end)
  end
end

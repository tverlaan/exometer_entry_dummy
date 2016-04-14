defmodule Exometer.Entry do
  @moduledoc """
  Behaviour module for exometer_entry in Elixir
  """

  @callback behaviour :: :entry

  @callback new(  :exometer.name(),
                  :exometer.type(),
                  :exometer.options()
                ) :: :ok | {:ok, :exometer.ref()} | {:error, term}

  @callback delete(   :exometer.name(),
                      :exometer.type(),
                      :exometer.ref()
                    ) :: :ok | {:error, term}

  @callback get_datapoints(   :exometer.name(),
                              :exometer.type(),
                              :exometer.ref()
                            ) :: :exometer.datapoints()

  @callback get_value(  :exometer.name(),
                        :exometer.type(),
                        :exometer.ref(),
                        :exometer.datapoints()
                      ) :: [{:exometer.datapoint(), :exometer.value()}]

  @callback reset(  :exometer.name(),
                    :exometer.type(),
                    :exometer.ref()
                  ) :: :ok | {:ok, :exometer.value()} | {:error, term}

  @callback sample( :exometer.name(),
                    :exometer.type(),
                    :exometer.ref()
                  ) :: :ok | {:error, term}

  @callback setopts(  :exometer.entry(),
                      :exometer.options(),
                      :exometer.status()
                    ) :: :ok | {:error, term}

  @callback update( :exometer.name(),
                    :exometer.value(),
                    :exometer.type(),
                    :exometer.ref()
                  ) :: :ok | {:ok, :exometer.value()} | {:error, term}


  @doc false
  defmacro __using__(_) do
    quote location: :keep do
      @behaviour :exometer_entry

      #
      # not overridable, required entry implementation
      #
      @doc false
      def behaviour(), do: :entry

      @doc false
      def sample(_,_,_), do: :ok

      #
      # overridable
      #
      @doc false
      def delete(_name, _type, _ref), do: :ok

      @doc false
      def get_datapoints(_name, _type, _ref), do: []

      @doc false
      def reset(_name, _type, _ref), do: :ok

      @doc false
      def setopts(_entry, _opts, _type), do: :ok

      defoverridable [setopts: 3, delete: 3, get_datapoints: 3, reset: 3,

                      ]
    end
  end

end

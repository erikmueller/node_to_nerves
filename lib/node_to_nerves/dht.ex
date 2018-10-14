defmodule NodeToNerves.Dht do
    use GenServer
    require Logger

    def start_link(opts) do
        GenServer.start_link(__MODULE__, opts)
    end

    def init(state) do
        schedule_read()

        {:ok, state}
    end

    def handle_info(:read, state) do
        case NervesDHT.read(:dht22, 7, 10) do
            {:ok, h, t} ->
                Logger.info "Humidity: #{h}% | Temperature: #{t} C"
            {:error, reason} ->
                Logger.warn "Failed to read sensor: #{reason}"
        end

        schedule_read()

        {:noreply, state}
    end

    defp schedule_read do
        Logger.debug "NodeToNerves: scheduling read"

        Process.send_after self, :read, 2000
    end
end

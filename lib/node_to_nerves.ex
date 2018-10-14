defmodule NodeToNerves do
    use Application

    def start(_type, args \\ []) do
        import Supervisor.Spec, warn: false
        # Define workers and child supervisors to be supervised
        children = [
            worker(NodeToNerves.Dht, [args]),
        ]

        # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
        # for other strategies and supported options
        opts = [strategy: :one_for_one, name: NodeToNerves.Supervisor]
        Supervisor.start_link(children, opts)
    end
end

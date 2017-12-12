# Trains Problem

This is my Ruby-based solution for the [trains problem](PROMPT.md).


### Run the Code

Pipe the sample input via STDIN to the `bin/test` script:

`bin/test < input`

The output is in the format of the problem prompt.


### Run the Tests

RSpec is used for testing. Prior to running tests, ensure you have the dependencies installed:

    bundle install

Then you can run the tests via

    bundle exec rspec


### My Approach

I tried to keep things pretty simple while also using a pattern that I tend to lean on quite often: domain objects.

The project was broken into the following domain pieces:

- `Route` – which represents a route of stops (vertexes) such as ABCD and an optional distance.
- `Edge` – builds on the `Route` by providing a convenience for parsing input like CD4 and turning that into an `Edge` that can be placed on the graph.
- `Vertex` – a container representing a stop, such as `A`, to store edges connected to that stop.
- `Graph` – pulls it all together and manages building the vertexes, attaching edges, and traversing the graph.
- `DepthFirstSearch` – a service-type class which provides isolation for performing depth-first search of the graph.


Due to the time constraints and the specific structure of this assignment, a few decisions were made:

1. I opted for an adjacency list graph representation. With this approach, the `Graph` stores verticies (rail stops, represented by a `Vertex`) and each `Vertex` stores the edges (route+distance between stations) represented by `Edge` object.
2. I opted to use a depth-first path search to query trips from the graph as opposed to a breadth-first approach due to the limited size of the graph and the simplicity of the connections.

# Blendex

Pre-alpha - do not use!

```
$ iex -S mix
...
iex(1)> Blendex.Worker.send_command("bpy.ops.mesh.primitive_cube_add(size=2, enter_editmode=False, align='WORLD', location=(1,2,3), scale=(1,1,1))")
:ok
```



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `blendex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:blendex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/blendex>.


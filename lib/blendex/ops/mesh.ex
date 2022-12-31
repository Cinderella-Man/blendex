defmodule Blendex.Ops.Mesh do
  @doc """
  Based on https://docs.blender.org/api/current/bpy.ops.mesh.html

  Names needs to specified at the moment of adding
  """

  def primitive_cube_add(args \\ []) do
    maybe_add_name("bpy.ops.mesh.primitive_cube_add", args)
  end

  def primitive_uv_sphere_add(args \\ []) do
    maybe_add_name("bpy.ops.mesh.primitive_uv_sphere_add", args)
  end

  def maybe_add_name(action, args) do
    {name, rest_of_args} = Keyword.pop(args, :name, false)

    [%{
      action: action,
      args: rest_of_args
    }] ++ _maybe_add_name(name)
  end

  def _maybe_add_name(false), do: []
  def _maybe_add_name(name), do: [{:raw, "bpy.context.object.name = '#{name}'"}]

end

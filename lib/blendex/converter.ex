defmodule Blendex.Converter do

  def generate_command(%{type: :cube} = shape) do
    "bpy.ops.mesh.primitive_cube_add(size=#{shape.size}, " <>
    "enter_editmode=False, align='WORLD', " <>
    "location=(#{tuple_to_list(shape.location)}), scale=(#{tuple_to_list(shape.scale)}))"
  end

  def tuple_to_list(data) do
    data
    |> Tuple.to_list()
    |> Enum.join(", ")
  end
end
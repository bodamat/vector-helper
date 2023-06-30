@tool
extends EditorPlugin

var script_3d: Script = preload("res://addons/vector_helper/vector3d/vector3d.gd")
var icon_3d: Texture2D = preload("res://icon.svg")


func _enter_tree() -> void:
	add_custom_type("Vector3D", "MeshInstance3D", script_3d, icon_3d)
	pass


func _exit_tree() -> void:
	remove_custom_type("Vector3D")
	pass

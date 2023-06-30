@tool
extends MeshInstance3D
class_name Vector3D

var vector_mesh: Mesh = preload("res://addons/vector_helper/vector3d/vector.obj")
var vector_mat: BaseMaterial3D = preload("res://addons/vector_helper/vector3d/m_vector3d.tres")

var mat: BaseMaterial3D

@export var size: float = 0.2 :
	set(value):
		size = value
		_change_size()

@export var color: Color = Color("c36e26") :
	set(value):
		color = value
		_change_color()

@export var debug: bool = false


# Private functions
func _ready() -> void:
	visible = Engine.is_editor_hint() or debug
	
	mesh = vector_mesh
	cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	_change_size()
	
	mat = vector_mat.duplicate()
	set_surface_override_material(0, mat)
	_change_color()
	

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_TRANSFORM_CHANGED:
			_change_size()


func _change_size():
	scale = Vector3(size, size, size)


func _change_color() -> void:
	if not mat: return
	mat.albedo_color = color


# Public functions
func get_basis() -> Basis:
	return transform.basis


func get_forward_vector() -> Vector3:
	return -transform.basis.z


func get_right_vector() -> Vector3:
	return transform.basis.x


func get_up_vector() -> Vector3:
	return transform.basis.y

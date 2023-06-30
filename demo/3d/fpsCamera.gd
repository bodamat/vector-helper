extends Camera3D
class_name FPSCamera


## Mouse sensitive
@export_range(0.1, 1) var sensitive: float = 0.45
## Min degree to rotate by x
@export var min_clamp: float = 80
## Max degree to rotate by x
@export var max_clamp: float = 80
## Invert mouse rotation by x
@export var invert_x: bool = false
## Invert mouse rotation by y
@export var invert_y: bool = false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	# DEBUG
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	# END DEBUG
	
	rotate_camera(event)

## Camera rotation
func rotate_camera(event: InputEvent) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	if not event is InputEventMouseMotion:
		return
	
	event = event as InputEventMouseMotion
	
	rotation.x += -event.relative.y * sensitive * 0.01 * (-1 if invert_x else 1)
	rotation.y += -event.relative.x * sensitive * 0.01 * (-1 if invert_y else 1)
	rotation.x = clampf(rotation.x, -deg_to_rad(min_clamp), deg_to_rad(max_clamp))

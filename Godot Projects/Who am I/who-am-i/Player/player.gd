extends CharacterBody3D
@onready var camera_3d: Camera3D = $Camera3D

var speed : float = 300
var jump_height: float = 300
var gravity  :float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	Input.MouseMode.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	
	var direction = Vector3(Input.get_axis("ui_left", "ui_right"), 0 , Input.get_axis("ui_up", "ui_down"))
	var look_direction = direction.rotated(Vector3.UP, camera_3d.global_rotation.y)
	
	if !is_on_floor():
		velocity.y +=  -gravity * delta
	
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		#amera_3d.rotate_y(.2)
		velocity.y += jump_height * delta
	
	if direction:
		velocity.x = look_direction.x * speed * delta
		velocity.z = look_direction.z * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, 20 * delta)
		velocity.z = move_toward(velocity.z, 0, 20 * delta)
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if Input.MouseMode.MOUSE_MODE_CAPTURED:
		pass

extends CharacterBody3D
const SPEED = 5
const JUMP_SPEED = 5
var gravity : float
var neck


func _ready():
	gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	neck = $Neck
	
func _process(delta):
	

	
	velocity.y -= gravity * delta
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	var direction = input_dir
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.y * SPEED
	else:
		velocity.x = 0
		velocity.z = 0
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED
		
		
	if Input.is_action_just_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	move_and_slide()
func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		print_debug("locked")
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			neck.rotate_x(-event.relative.y * 0.01)
		

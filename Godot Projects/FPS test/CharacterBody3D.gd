extends CharacterBody3D
const SPEED = 5
const JUMP_SPEED = 5
var gravity : float


func _ready():
	gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
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
		pass#MouseMode(Input.MOUSE_MODE_CAPTURED)
	
	move_and_slide()

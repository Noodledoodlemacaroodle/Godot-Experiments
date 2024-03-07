extends CharacterBody3D

@onready var player_model = $humanoid
@onready var anim_player = player_model.get_child(1)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print_debug(anim_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !is_on_floor():
		position.y -= 1 * delta
		apply_floor_snap()
	
	var facing = global_transform.basis.z
	if Input.is_action_pressed("ui_up"):
		velocity = (facing * 50 )* delta
		anim_player.play("CharacterWalk")
	else:
		velocity.x = move_toward(velocity.x, 0, 10 * delta)
		velocity.z = move_toward(velocity.z, 0, 10 * delta)
		anim_player.play("CharacterIdle")

	if Input.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(50 * delta))
	if Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(-50 * delta))

	move_and_slide()

extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ACCELERATION = .5
const DECELERATION = .2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _model: Node3D = $Mesh
@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var sep_ray_shape = $SpringForce/SeparationRayShape

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (_spring_arm.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

	move_and_slide()
	
	if velocity.length() > 0.2:
		var look_direction = Vector2(velocity.z, velocity.x)
		_model.rotation.y = look_direction.angle()
		

func _process(delta):
	_spring_arm.position = position
	
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()
		
	

#@export var speed := 7.0
#@export var jump_strength := 20.0
#
#var _velocity := Vector3.ZERO
#var _snap_vector := Vector3.DOWN
#
#
#@onready var _spring_arm: SpringArm3D = $SpringArm3D
#@onready var _model: Node3D = $Mesh
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#var move_direction := Vector3.ZERO
	#move_direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	#move_direction.z = Input.get_action_strength("Backward") - Input.get_action_strength("Forward")
	#move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	#
	#_velocity.x = move_direction.x * speed
	#_velocity.z = move_direction.z * speed
	#_velocity.y -= gravity * delta
	#move_and_slide()


func _on_spring_force_body_entered(body):
	print_debug("IS ON FLOOR")
	
	

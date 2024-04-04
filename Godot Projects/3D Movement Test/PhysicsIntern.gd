extends RigidBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ACCELERATION = .5
const DECELERATION = .2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var spring_force = 10
var ground_position

@onready var _model: Node3D = $Mesh
@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var sep_ray_shape = $SpringForce/SeparationRayShape
@onready var direction_node = $DirectionNode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	_spring_arm.position = position
	
		
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction_node.rotation = Vector3(0,_spring_arm.rotation.y,0) 
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (direction_node.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if ground_position != null:
		var depth = ground_position.y - global_position.y
		if depth > -10:
			apply_central_force(Vector3.UP * spring_force * gravity * depth)
			
			print("up we go?")
	
	if direction:
		apply_central_force(direction * SPEED)
		#velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION)
		#velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCELERATION)
	#else:
		#velocity.x = move_toward(velocity.x, 0, DECELERATION)
		#velocity.z = move_toward(velocity.z, 0, DECELERATION)


func _on_area_3d_body_entered(body):
	ground_position = body.position
	print("GROOUND HIT")

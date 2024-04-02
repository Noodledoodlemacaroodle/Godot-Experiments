extends CharacterBody3D

@export var speed := 7.0
@export var jump_strength := 20.0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var _model: Node3D = $Mesh

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	move_direction.z = Input.get_action_strength("Backward") - Input.get_action_strength("Forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	move_and_slide()

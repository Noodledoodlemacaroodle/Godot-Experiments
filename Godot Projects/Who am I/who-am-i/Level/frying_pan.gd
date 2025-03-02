extends Node3D

@onready var area_3d: Area3D = $MeshInstance3D2/MeshInstance3D/Area3D
@onready var static_body_3d: StaticBody3D = $MeshInstance3D2/StaticBody3D


var position_x : float
var position_y : float
var rotation_x : float
var rotation_y : float

var is_in_fire : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_fire:
		static_body_3d.heat += .1
		#print(static_body_3d.heat)
	elif static_body_3d.heat >=0:
		static_body_3d.heat -= .1
		#print(static_body_3d.heat)
	
func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		
		if Input.is_action_pressed("Interact"):
			
			position.x += (event.relative.x * get_process_delta_time())/10
			position.z += (event.relative.y * get_process_delta_time())/10
		else:
			rotation.x += (-event.relative.y * get_process_delta_time()) /10
			rotation.z += (event.relative.x * get_process_delta_time())/10
			rotation.y += (-event.relative.x * get_process_delta_time())/10

#func _physics_process(delta: float) -> void:
	#
	#rotation.x = rotation_x
	#rotation.z = rotation_y
	#
	#position.x =  position_x
	#position.z = position_y


#func _on_static_body_3d_body_shape_exited(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	#if body.is_in_group("Fire"):
		#
		


func _on_area_3d_area_entered(area: Area3D) -> void:
	is_in_fire = true


func _on_area_3d_area_exited(area: Area3D) -> void:
	is_in_fire = false

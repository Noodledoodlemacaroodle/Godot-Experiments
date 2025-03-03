extends RigidBody3D

var frying_pan
var collision_point : Vector3
var collision_normal : Vector3
var heat: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if frying_pan != null && frying_pan.global_position.y < global_position.y:
		var center_position = frying_pan.global_position - global_position
		apply_central_force(center_position)
		
		#print(center_position)
		

func _on_body_entered(body: Node) -> void:
	#print("hhh")
	if body.is_in_group("Frying Pan"):
		frying_pan = body
		heat = frying_pan.heat
		apply_impulse((collision_normal * heat) * get_process_delta_time(), collision_point)
		#print(heat)
		
	
	

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	collision_point = state.get_contact_collider_position(0)
	collision_normal = state.get_contact_local_normal(0)
	
#func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	#frying_pan = body
	#print("Collision!")

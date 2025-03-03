extends Area3D

@export var heat_value : float
var Pan

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Pan != null:
		Pan.get_parent().get_parent().get_parent().static_body_3d.heat += heat_value
		
		#print("heating up!")


#func _on_body_entered(body: Node3D) -> void:
	#print(body)
	#if body.is_in_group("Frying Pan"):
		#Pan = body
		#Pan.is_in_fire = true
	#
#
#func _on_body_exited(body: Node3D) -> void:
	#if body.is_in_group("Frying Pan"):
		#Pan.is_in_fire = false
		#Pan = null
		


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Frying Pan"):
		Pan = area
	if area.is_in_group("Food"):
		area.apply_central_impulse(Vector3.UP)
		#Pan.is_in_fire = true
		print("pop")
	



func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("Frying Pan"):
		#Pan.is_in_fire = false
		Pan = null

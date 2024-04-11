extends Node3D

var pickup_obj
var is_carrying : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pickup_obj != null and Input.is_action_pressed("ui_page_up"):
		#pickup_obj.get_child(2).disabled = true
		pickup_obj.remove_child(pickup_obj)
		pickup_obj.add_child(self)
		is_carrying = true
		print_debug(pickup_obj.get_parent())
		
	if is_carrying:
		pickup_obj.position += 50
	else:
		pickup_obj = null


func _on_area_3d_body_entered(body):
	
	if body.has_method("Pickup"):
		pickup_obj = body.get_parent()
		
	


func _on_area_3d_body_exited(body):
	if body.has_method("Pickup"):
		pickup_obj = null

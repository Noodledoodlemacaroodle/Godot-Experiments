extends StaticBody3D

@export var heat: float = 0

var is_in_fire : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if !is_in_fire and heat >= 0:
		#heat -= .1
	#else:
		#heat +=.1
	#if is_in_fire:
		#print(heat)
	pass

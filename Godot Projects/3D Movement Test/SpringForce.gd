extends Area3D

@onready var raycast = $RayCast3D
@onready var separation_ray_shape = $SeparationRayShape

# Called when the node enters the scene tree for the first time.
func _ready():
	raycast.debug_shape_custom_color = Color(1,0,0)
	#separation_ray_shape.length = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

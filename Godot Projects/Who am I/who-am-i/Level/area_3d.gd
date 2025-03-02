extends Area3D
@onready var static_body_3d: StaticBody3D = $"../../StaticBody3D"


@export var heat: float = 0

var is_in_fire : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_in_fire and heat >= 0:
		static_body_3d.heat -= heat
	else:
		static_body_3d.heat += heat

	is_in_fire = static_body_3d.is_in_fire

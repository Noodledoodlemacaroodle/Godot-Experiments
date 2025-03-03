extends Area3D
@onready var camera_3d: Camera3D = $"../Camera3D"
var is_cooking: bool
@onready var frying_pan: Node3D = $"../Frying Pan"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		camera_3d.set_current(true)
		is_cooking = true
		body.set_process_unhandled_input(false)
		body.set_process_input(false)
		frying_pan.set_process_unhandled_input(true)
		frying_pan.set_process(true)

extends State

@export var fall_state: State

@export var idle_state: State

@export var move_state: State

@export var jump_force : float = 9.0

func enter() -> void:
	super()
	parent.velocity.y = +jump_force

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta
	
	if parent.velocity.y < 0:
		return fall_state
		
	var movement = Input.get_axis("ui_left", "ui_right") * move_speed
	parent.global_rotation.y = lerp(parent.global_rotation.y,clamp(movement,-180.0,0.0),0.3)
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null

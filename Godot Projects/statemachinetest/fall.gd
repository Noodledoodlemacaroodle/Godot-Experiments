extends State


@export var idle_state: State

@export var move_state: State


func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta
	
	
	var movement = Input.get_axis("ui_left", "ui_right") * move_speed
	
	
		
	parent.velocity.x= movement
	parent.global_rotation.y = lerp(parent.global_rotation.y,clamp(movement,-180.0,0.0),0.3)
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null

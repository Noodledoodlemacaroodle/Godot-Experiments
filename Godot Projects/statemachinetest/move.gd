extends State

@export var fall_state: State

@export var idle_state: State

@export var jump_state: State


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("ui_accept") and parent.is_on_floor():
		return jump_state
	return null
	
func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta
	
	var movement = Input.get_axis("ui_left", "ui_right") * move_speed
	
	if movement == 0:
		return idle_state
		
	#parent.animations.flip_h = movement <0
	parent.global_rotation.y = lerp(parent.global_rotation.y,clamp(movement,-180.0,0.0),0.3)
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null

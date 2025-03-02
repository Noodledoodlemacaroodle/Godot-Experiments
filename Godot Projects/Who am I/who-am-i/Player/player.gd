extends CharacterBody3D
@onready var camera_3d: Camera3D = $Neck/Camera3D
@onready var neck: Node3D = $Neck
@onready var label: RichTextLabel = $Neck/Camera3D/Control/Label
@onready var text_timer: Timer = $Neck/Camera3D/Control/Label/text_timer

var speed : float = 300
var jump_height: float = 300
var gravity  :float = ProjectSettings.get_setting("physics/3d/default_gravity")
var in_dialogue: bool = false:
	set(dialogue):
		in_dialogue = dialogue
		if in_dialogue:
			label.show()
			var tween = create_tween()
			tween.tween_property(label, "visible_ratio", 1, text_timer.wait_time/2)
		else:
			label.hide()
			label.visible_ratio = 0
var can_exit_dialogue : bool

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	
	var direction = Vector3(Input.get_axis("Left", "Right"), 0 , Input.get_axis("Forward", "Back"))
	var look_direction = direction.rotated(Vector3.UP, camera_3d.global_rotation.y)
	
	if Input.is_action_just_pressed("Interact") and can_exit_dialogue:
		can_exit_dialogue = false
		exit_dialogue()
	
	if !is_on_floor():
		velocity.y +=  -gravity * delta
	
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		#amera_3d.rotate_y(.2)
		velocity.y += jump_height * delta
	
	if direction:
		velocity.x = look_direction.x * speed * delta
		velocity.z = look_direction.z * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, 20 * delta)
		velocity.z = move_toward(velocity.z, 0, 20 * delta)
	clamp(camera_3d.rotation.x, deg_to_rad(0),deg_to_rad(90))
	
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if in_dialogue == false:
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			
			camera_3d.rotate_x(deg_to_rad(-event.relative.y * 10 * get_process_delta_time()))
			neck.rotate_y(deg_to_rad(-event.relative.x * 10 * get_process_delta_time()))
			
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-70), deg_to_rad(50))
		
		
func exit_dialogue():
	in_dialogue = false
	
	

extends RayCast3D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../Control/CenterContainer/AnimatedSprite2D"
@onready var player: CharacterBody3D = $"../../.."
@onready var label: RichTextLabel = $"../Control/Label"
@onready var text_timer: Timer = $"../Control/Label/text_timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		animated_sprite_2d.set_animation("Interact")
		if Input.is_action_just_pressed("Interact") and player.in_dialogue == false:
			player.in_dialogue = true
			get_collider().dialogue(label)
			text_timer.start()
			
	#if Input.is_action_just_pressed("Interact") and !text_timer.is_stopped():
		#player.exit_dialogue()
		
		#if Input.is_action_just_pressed("Interact") and player.in_dialogue == true:
			#player.in_dialogue = false
			
	else:
		animated_sprite_2d.set_animation("default")


func _on_text_timer_timeout() -> void:
	player.exit_dialogue()

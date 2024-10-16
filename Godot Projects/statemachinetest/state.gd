class_name State
extends Node

@export var animation_name: String

@export var move_speed: float = 3

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

#Referens till parent (spelaren)
var parent: Player
# Called when the node enters the scene tree for the first time.
func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null

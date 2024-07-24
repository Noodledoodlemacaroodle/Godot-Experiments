extends RigidBody3D

## How much vertical force to apply when moving.
@export_range(750,3000) var thrust: float = 1000
@export var torque_thrust: float = 100

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var left_boooster_particles: GPUParticles3D = $LeftBooosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles

var is_transitioning: bool = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		booster_particles.emitting = true
		if rocket_audio.playing == false:
			rocket_audio.play()
	else:
		rocket_audio.stop()
		booster_particles.emitting = false
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0,0,torque_thrust * delta))
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0,0,-torque_thrust * delta))
		left_boooster_particles.emitting = true
	else:
		left_boooster_particles.emitting = false


func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			complete_level(body.file_path)
		if "Hazard" in body.get_groups():
			crash_sequence()
		#rint(body.name)

func crash_sequence() -> void:
	explosion_audio.play()
	set_process(false)
	print("KABOOOM")
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
	
func complete_level(next_level_file: String):
	success_audio.play()
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))

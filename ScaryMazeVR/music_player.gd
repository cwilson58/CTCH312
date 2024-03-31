class_name MusicPlayer extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	_play_sound(true)

func _play_sound(first_play : bool) -> void:
	var wait_name := randf_range(2,60) if !first_play else 0.0 # be silent for some time to increase spookyness
	await get_tree().create_timer(wait_name).timeout
	self.play()
	await self.finished
	_play_sound(false)
	

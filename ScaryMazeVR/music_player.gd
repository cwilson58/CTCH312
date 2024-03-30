class_name MusicPlayer extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	_play_sound()

func _play_sound():
	self.play()
	await self.finished
	var wait_name := randf_range(2,60) # be silent for some time to increase spookyness
	await get_tree().create_timer(wait_name).timeout
	_play_sound()
	

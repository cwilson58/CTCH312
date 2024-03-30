class_name MusicPlayer extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	_play_sound()

func _play_sound():
	self.play()
	await self.finished
	_play_sound()
	

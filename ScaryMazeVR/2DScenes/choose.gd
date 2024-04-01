class_name EndChoice extends CanvasLayer

signal choice(took_skin : bool)

func _ready():
	choice.connect(MessageBus._on_final_choice_made)

func _on_take_skin_pressed():
	choice.emit(true)


func _on_stop_reaver_pressed():
	choice.emit(false)

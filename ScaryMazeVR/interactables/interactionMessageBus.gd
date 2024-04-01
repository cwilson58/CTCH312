class_name InteractionMessageBus extends Node

signal skin_reaver_choice(take_skin : bool)

func _on_final_choice_made(take_skin : bool):
	skin_reaver_choice.emit(take_skin)

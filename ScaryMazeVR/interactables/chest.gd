class_name Chest extends StaticBody3D

@export var final_chest : bool = false

func _on_interactable_focused(interactor):
	print("FOCUS")


func _on_interactable_interacted(_interactor):
	$AudioStreamPlayer3D.play()
	## TODO Change to skin reaver meeting
	if(final_chest):
		get_tree().change_scene_to_file("res://credits.tscn")


func _on_interactable_unfocused(interactor):
	print("NO FOCUS")

class_name Chest extends StaticBody3D


func _on_interactable_focused(interactor):
	print("FOCUS")


func _on_interactable_interacted(interacttor):
	$AudioStreamPlayer3D.play()


func _on_interactable_unfocused(interacttor):
	print("NO FOCUS")

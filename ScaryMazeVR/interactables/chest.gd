class_name Chest extends StaticBody3D

@export var final_chest : bool = false

func _on_interactable_focused(_interactor):
	$HighlightMesh.show()


func _on_interactable_interacted(_interactor):
	$AudioStreamPlayer3D.play()
	$Viewport2Din3D.show()

func _on_interactable_unfocused(_interactor):
	$HighlightMesh.hide()

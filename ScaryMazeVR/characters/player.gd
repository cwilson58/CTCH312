extends XROrigin3D

var _interact_event := InputEventAction.new()

func _on_right_controller_button_pressed(name : String) -> void:
	if(name == "ax_button"):
		_interact_event.action = "interact"
		_interact_event.pressed = true
		Input.parse_input_event(_interact_event)
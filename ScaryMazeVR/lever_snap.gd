## LeverSnap will emit a signal representing a value change once a user DROPS it.
class_name LeverSnap extends Node3D

var last_position : int = 0
enum POSITION {DOWN = -1, MID = 0, UP = 1}

signal position_changed(position : int)

func _on_interactable_handle_lever_dropped(transform : Transform3D):
	var facing = -transform.basis.z
	var angle = rad_to_deg(facing.angle_to(Vector3.DOWN))
	var pos : int = POSITION.MID
	if(angle <= 80):
		pos = POSITION.UP
	elif(angle >= 100):
		pos = POSITION.DOWN
	
	if(pos != last_position):
		position_changed.emit(pos)
		last_position = pos

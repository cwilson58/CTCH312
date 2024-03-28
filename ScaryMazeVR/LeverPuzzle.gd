class_name LeverPuzzle extends Node3D

var code : int = -1
var current_attempt : int = 0
var valid_use : bool = false

signal code_correct

func _ready():
	code = randi_range(1,15)

func check_correct() -> void:
	if(code == current_attempt):
		code_correct.emit()

func _on_lever_snap_01_position_changed(position : int) -> void:
	if(position > 0):
		current_attempt |= 1
	else:
		current_attempt &= 0b1110
	check_correct()
	
func _on_lever_snap_02_position_changed(position : int) -> void:
	if(position > 0):
		current_attempt |= (1 << 1)
	else:
		current_attempt &= 0b1101
	check_correct()

func _on_lever_snap_03_position_changed(position : int) -> void:
	if(position > 0):
		current_attempt |= (1 << 2)
	else:
		current_attempt &= 0b1011
	check_correct()

func _on_lever_snap_04_position_changed(position : int) -> void:
	if(position > 0):
		current_attempt |= (1 << 3)
	else:
		current_attempt &= 0b0111
	check_correct()

extends PathFollow3D

func _physics_process(delta) -> void:
	const move_speed := 4
	progress += move_speed * delta

## Class for monsters that can be caught in game
## Audio clip: https://pixabay.com/sound-effects/dragon-roar-96996/
class_name Monster extends CharacterBody3D

@onready var light = $SpotLight3D
var max_distance_squared
var max_angle
var target_velocity = Vector3.ZERO

func _ready():
	max_distance_squared = light.spot_range*light.spot_range
	max_angle = deg_to_rad(light.spot_angle)

func _physics_process(delta):
	# force monster to fallow the laws of gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (9.81 * delta)
	velocity = target_velocity
	move_and_slide()

func _process(_delta):
	light.light_color = Color.WHITE
	var my_pos : Vector3 = global_transform.origin
	for body : Node3D in get_tree().get_nodes_in_group("monster_visible"):
		var body_pos : Vector3 = body.global_transform.origin
		
		if my_pos.distance_squared_to(body_pos) > max_distance_squared:
			continue
		
		var monster_facing = -global_transform.basis.z
		
		var monster_to_body = my_pos.direction_to(body_pos)
		var monster_to_body_norm = monster_to_body.normalized()
		
		var cos_angle = monster_to_body_norm.dot(monster_facing)
		var angle = acos(cos_angle)
		if angle < max_angle:
			light.light_color = Color.RED
			if !$Roar.playing:
				$Roar.play()

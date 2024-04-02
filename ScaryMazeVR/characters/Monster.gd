## Class for monsters that can be caught in game
## Audio clip: https://pixabay.com/sound-effects/dragon-roar-96996/
class_name Monster extends CharacterBody3D

@onready var light = $SpotLight3D
@export var moving : bool = true
@export var can_detect : bool = true

var max_distance_squared
var max_angle
var target_velocity = Vector3.ZERO
@onready var dialog_audio : AudioStreamPlayer3D = $Dialog
@onready var player = get_tree().root.get_node_or_null("Player")
var detection_areas : Array[MonsterDetectionArea3d]

signal player_detected

func _ready():
	max_distance_squared = light.spot_range*light.spot_range
	max_angle = deg_to_rad(light.spot_angle)
	
	if (moving):
		$skin_reaver/AnimationPlayer.play("crawl")
	else:
		$skin_reaver/AnimationPlayer.play("idle_animations/idle")
	# THIS IS INF RECURSIVE AND SHOULD BE THE LAST METHOD CALLED.
	_on_timer_timeout()
	
func _physics_process(delta):
	# force monster to fallow the laws of gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (9.81 * delta)
	else: # set to zero as we have no jumping in the game
		target_velocity.y = 0
	velocity = target_velocity
	move_and_slide()

func _process(_delta):
	if(!can_detect):
		return
	light.light_color = Color.WHITE
	var my_pos : Vector3 = global_transform.origin
	for body : Node3D in get_tree().get_nodes_in_group("monster_visible"):
		var body_pos : Vector3 = body.global_transform.origin
		if !player_detectable():
			continue
		if my_pos.distance_squared_to(body_pos) > max_distance_squared:
			continue
		
		var monster_facing = -global_transform.basis.z
		
		var monster_to_body = my_pos.direction_to(body_pos)
		var monster_to_body_norm = monster_to_body.normalized()
		
		var cos_angle = monster_to_body_norm.dot(monster_facing)
		var angle = acos(cos_angle)
		if angle < max_angle:
			if (body != null):
				body.get_caught()
			light.light_color = Color.RED

func player_detectable() -> bool:
	for detection_area : MonsterDetectionArea3d in detection_areas:
		if detection_area.player_present:
			return true
	return false

func _on_timer_timeout():
	dialog_audio.play()
	await get_tree().create_timer(randf_range(15,60)).timeout
	_on_timer_timeout()

func add_detection_area(area : MonsterDetectionArea3d):
	if !detection_areas.has(area):
		detection_areas.append(area)

func remove_detection_area(area : MonsterDetectionArea3d):
	detection_areas.erase(area)

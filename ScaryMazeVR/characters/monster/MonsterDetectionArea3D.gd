## Area3D subclass that holds the current zone of a monster.
## A Monster can be in many zones, same with a player, as there can be overlap.
class_name MonsterDetectionArea3d extends Area3D

var curr_monster : Monster
var player_present := false

func _on_body_entered(body):
	if body is Monster:
		# if the monster can not detect you, ignore it.
		if !body.can_detect: 
			return
		curr_monster = body
		body.add_detection_area(self)
	elif body is CharacterBody3D:
		player_present = true

func _on_body_exited(body):
	if body is Monster:
		# if the monster can not detect you, ignore it.
		if !body.can_detect: 
			return
		curr_monster = null
		body.remove_detection_area(self)
	# player is not detected as its parent class, not sure why.
	elif body is CharacterBody3D:
		player_present = false

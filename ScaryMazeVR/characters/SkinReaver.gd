## Story Telling class, only ONE node per level!
class_name SkinReaver extends Node3D

@onready var intro : AudioStreamPlayer = $Intro
@onready var forgot_monster : AudioStreamPlayer = $ForgotMonster
@onready var found_skin : AudioStreamPlayer = $FoundSkin
@onready var not_worthy : AudioStreamPlayer = $NotWorthy
@onready var you_may_leave : AudioStreamPlayer = $YouMayLeave
@onready var wrong_way : AudioStreamPlayer = $WrongWay
@onready var are_you_sure : AudioStreamPlayer = $AreYouSure
@onready var monster_hug : AudioStreamPlayer = $MonsterHug
@onready var solved_puzzles : AudioStreamPlayer = $FiguredPuzzlesOut
@onready var getting_warmer : AudioStreamPlayer = $GettingWarmer

var puzzles_correct : int = 0

## play the intro whenever the skin reaver is added to the level
func _ready():
	intro.play()
	MessageBus.skin_reaver_choice.connect(_on_chest_choice_made)

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		monster_hug.play()

func _on_lever_puzzle_01_code_correct():
	puzzles_correct |= 1
	_are_all_puzzles_solved()

func _on_lever_puzzle_02_code_correct():
	puzzles_correct |= (1 << 1)
	_are_all_puzzles_solved()

func _on_lever_puzzle_03_code_correct():
	puzzles_correct |= (1 << 2)
	_are_all_puzzles_solved()

func _are_all_puzzles_solved():
	if (puzzles_correct == 0b111):
		solved_puzzles.play()


func _on_area_laugh_body_entered(body):
	if body is CharacterBody3D:
		wrong_way.play()

func _on_area_are_you_sure_body_entered(body):
	if body is CharacterBody3D:
		are_you_sure.play()

func _on_getting_warmer_body_entered(body):
	if body is CharacterBody3D:
		getting_warmer.play()


func _on_forgot_monster_body_entered(body):
	if body is CharacterBody3D:
		forgot_monster.play()


func _on_chest_choice_made(choice : bool):
	if(choice):
		you_may_leave.play()
		await you_may_leave.finished
		get_tree().change_scene_to_file("res://credits.tscn")
	else:
		not_worthy.play()
		await not_worthy.finished
		get_tree().change_scene_to_file("res://credits.tscn")

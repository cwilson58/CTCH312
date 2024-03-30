class_name PlayerInteractor extends Interactor

@export var player : VRPlayer

var cached_closest : Interactable

func _ready():
	controller = player

func _physics_process(delta):
	var new_closest : Interactable = get_closest_interactable()
	if(new_closest != cached_closest):
		if(is_instance_valid(cached_closest)):
			unfocus(cached_closest)
		if new_closest:
			focus(new_closest)
		cached_closest = new_closest
		
func _input(event : InputEvent):
	if event.is_action_pressed("interact") && cached_closest:
		interact(cached_closest)
	
func _on_area_exited(area : Interactable):
	if(cached_closest == area):
		unfocus(area)

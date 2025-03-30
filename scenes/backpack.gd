extends Sprite2D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

func _input(event: InputEvent) -> void:
	if(event.as_text() == "G"):
		show()
		get_tree().paused = true
	elif(event.as_text() == "F"):
		hide()
		get_tree().paused = false

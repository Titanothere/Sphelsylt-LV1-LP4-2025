extends Sprite2D

var shown : bool
var currentContainer : int = 0
var aspectScene = preload("res://scenes/aspect.tscn")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	shown = false

func _input(event: InputEvent) -> void:
	if(event.as_text() == "G"):
		show()
		shown = true
		get_tree().paused = true
	elif(event.as_text() == "F"):
		hide()
		shown = false
		get_tree().paused = false
	if(shown):
		if (event.as_text() == "S"):
			if currentContainer >= 6:
				return
			var aspect = aspectScene.instantiate()
			aspect.type = DraggableAspect.AspectType.values().pick_random()
			aspect.updateLabel()
			var containerName = "PanelContainer" + str(currentContainer)
			currentContainer += 1
			var container = get_node(containerName)
			container.add_aspect(aspect)
	if(event.as_text() == "P"):
		var aspect0 = get_node("PanelContainer0").get_child(0)
		var aspect1 = get_node("PanelContainer1").get_child(0)
		print(aspect0.showAspectType(aspect0.type) + " " + aspect1.showAspectType(aspect1.type))

extends Sprite2D

var shown : bool
var currentContainer : int = 0
var aspectScene = preload("res://scenes/aspect.tscn")
signal make_asp

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	shown = false

func _input(event: InputEvent) -> void:
	#if(event.as_text() == "G"):
		
	#if(event.as_text() == "F"):

	if(event.as_text() == "P"):
		var aspect0 = get_node("PanelContainer0").get_child(0)
		var aspect1 = get_node("PanelContainer1").get_child(0)
		print(aspect0.showAspectType(aspect0.type) + " " + aspect1.showAspectType(aspect1.type))
	if (event.as_text() == "S"):
		if(shown):
			make_aspect(event)
			make_asp.emit()

func make_aspect(event):
			if currentContainer >= 6:
				return
			var aspect = aspectScene.instantiate()
			aspect.type = DraggableAspect.AspectType.values().pick_random()
			aspect.updateLabel()
			var containerName = "PanelContainer" + str(currentContainer)
			currentContainer += 1
			var container = get_node(containerName)
			container.add_aspect(aspect)

func show_aspect():
	show()
	shown = true
	get_tree().paused = true
	
func hide_aspect():
	hide()
	shown = false
	get_tree().paused = false

extends Sprite2D

var shown : bool
var currentContainer : int = 0
var aspectScene = preload("res://scenes/aspect.tscn")
signal make_asp
signal _on_aspect_update(stat0, stat1)


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	shown = false

func _input(event: InputEvent) -> void:
	if(event.as_text() == "P"):
		var aspect0 = get_node("PanelContainer0").get_child(0)
		var aspect1 = get_node("PanelContainer1").get_child(0)
		print(aspect0.showAspectType(aspect0.type) + " " + aspect1.showAspectType(aspect1.type))

func init_backpack():
	var aspect0 = aspectScene.instantiate()
	aspect0.type = DraggableAspect.AspectType.values().pick_random()
	aspect0.updateLabel()
	var aspect1 = aspectScene.instantiate()
	aspect1.type = DraggableAspect.AspectType.values().pick_random()
	aspect1.updateLabel()
	$Aspect0.add_aspect(aspect0)
	$Aspect1.add_aspect(aspect1)
	## EMIT SIGNAL TO WEAPON!
	_on_aspect_update.emit(aspect0, aspect1)

func make_aspect():
	$NewStat.clear_stat()
	$Trash0.clear_stat()
	$Trash1.clear_stat()
	var aspect = aspectScene.instantiate()
	aspect.type = DraggableAspect.AspectType.values().pick_random()
	aspect.updateLabel()
	$NewStat.add_aspect(aspect)
	
func show_backpack():
	show()
	shown = true
	get_tree().paused = true
	
func hide_backpack():
	hide()
	shown = false
	get_tree().paused = false


func _on_button_button_up() -> void:
	if $Aspect0.get_child_count() == 0 || $Aspect1.get_child_count() == 0:
		print("BONGONGONG - need to have two stats in aspect")
		return
	## EMIT SIGNAL TO WEAPON!
	_on_aspect_update.emit($Aspect0, $Aspect1)
	hide_backpack()

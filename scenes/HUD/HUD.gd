extends Control

var healthpip : PackedScene
var pipContainer : HBoxContainer
var pips : Array[TextureRect]

func _ready() -> void:
	healthpip = load("res://scenes/HUD/healthpip.tscn")
	pipContainer = get_node("Healthbar/PipContainer")
	add(9)
	pass

func _process(delta: float) -> void:
	pass

func add(change: int):
	for n in change:
		var newPip : TextureRect = healthpip.instantiate()
		pips.append(newPip)
		pipContainer.add_child(newPip)
	pass

func remove(change: int):
	for n in change:
		var oldPip : TextureRect = pips.pop_back()
		pipContainer.remove_child(oldPip)
		oldPip.free()
		pass

extends Node2D
@onready var stm = $StateMachine
signal spawned
var enemy
func _process(delta : float) -> void:
	connect("spawn", spawn_enemy)
	pass
func _ready() -> void:
	enemy = preload("res://scenes/enemy.tscn").instantiate()
	spawn_enemy()

func spawn_enemy() -> void:
	add_child(enemy)
	enemy.death.connect(stm.states["Combat"].on_death.bind())
	spawned.emit()

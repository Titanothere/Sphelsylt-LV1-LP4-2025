extends Node2D
@onready var stm = $StateMachine
signal spawned
func _process(delta : float) -> void:
	connect("spawn", spawn_enemy)
	pass
func _ready() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	var enemy = load("res://scenes/enemy.tscn").instantiate()
	add_child(enemy)
	enemy.death.connect(stm.states["Combat"].on_death.bind())
	spawned.emit()

extends Node
var alive : int = 0
var fsm: StateMachine
signal spawn

func _ready() -> void:
	#connect(on_death)
	connect("spawned", on_spawn)

func enter():
	spawn.emit()
	print("Hello from " + name + "!")
	# Exit 2 seconds later
	#await get_tree().create_timer(2.0).timeout
	#exit("Idle")
	


func exit(next_state):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	if event.pressed:
		print("From " + name + "")

func on_death() -> void:
	print("died")
	alive -= 0
	if alive == 0:
		fsm.change_to("Idle")
func on_spawn() -> void:
	alive += 1

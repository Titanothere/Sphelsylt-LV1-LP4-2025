extends Node2D
@onready var stm = $StateMachine

signal spawned
var enemy
var player
var total
var enemy_amount
var killed
var time
var spawn_cooldown
var Backpack : Sprite2D
var GunBlade : Node2D
var wait_on_press
var presses
var phi
var max_bound = 400
var min_bound = 300
func _process(delta : float) -> void:
	if killed == total:
		print("Round won!")
		total+=1
		enemy_amount = total
		killed = 0
		time = 0
		spawn_cooldown-=0.1
		Backpack.show_backpack()
		Backpack.make_aspect()
		
			
	time += delta
	if time >= spawn_cooldown:
		time = 0
		if(enemy_amount > 0):
			spawn_enemy()
func _ready() -> void:
	Backpack = $Player/Camera2D/Backpack
	GunBlade = $Player/Gunblade
	Backpack.make_asp.connect(made_aspect.bind())
	enemy = preload("res://scenes/enemy.tscn")
	total = 2
	enemy_amount = total
	spawn_cooldown = 0.5
	print(enemy_amount)
	killed = 0
	time = 0
	presses = 0
	player = $Player
	spawn_enemy()
	Backpack.init_backpack()
	GunBlade.addBackpack(Backpack)

func spawn_enemy() -> void:
	print("enemy spawned")
	var instance = enemy.instantiate()
	var phi = PI*2 * randf()
	var length = min_bound + (max_bound-min_bound) * randf()
	var player_pos = player.get_position()
	var x = cos(phi) * length + player_pos.x
	var y = sin(phi) * length + player_pos.y
	print("enemy pos: "+ str(x) + ", "+ str(y))
	print("player pos: " + str(player.get_position()))
	instance.set_position(Vector2(x, y))
	instance.death.connect(on_death.bind())
	add_child(instance)
	print(instance.get_position)
	enemy_amount = enemy_amount-1

func on_death() -> void:
	killed=killed +1
	print(killed)
	
func made_aspect() -> void:
	presses +=1
	print(presses)
	if(presses == 2):
		Backpack.hide_aspect()
		presses = 0

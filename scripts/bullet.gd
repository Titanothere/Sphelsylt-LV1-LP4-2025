extends Node2D
@export var speed : float = 300
var direction : Vector2

const BASE_SPREAD : float = 0.5

var bps : float = 5 # bullets per second
var timeout : float = 1
var dev : float = 1
var pp : Vector2 # this variable is really really stupid



func init_vals(rot, ppos, spread_mod) -> void:
	var real_rot = rot + randfn(0.0, 0.1*BASE_SPREAD*spread_mod)
	direction = Vector2(-cos(real_rot),-sin(real_rot)).normalized()
	self.rotation = real_rot
	pp = ppos
	


func _physics_process(delta: float) -> void:
	
	position += (direction * speed * delta) +  pp*delta
	#print(pp)
	timeout -= delta
	if timeout <= 0:
		queue_free()

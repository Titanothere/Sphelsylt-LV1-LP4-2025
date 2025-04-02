extends Area2D

# Define the base parameters of the weapon
var hitId = 0

const SWING_SPEED = 1
const SWING_DMG = 1
var rate_limit = 0
var last_pos : Vector2

## ASPECT AFFECTABLE STATS
var ATTACK_SPEED = 1

### Needs to be integrated with actual DAMAGE stat
var swing_dmg_mod = 1
var PROJECTILE_SPREAD = 1
var PROJECTILE_RANGE = 0
var PROJECTILE_SPEED = 0
var SWORD_SWING_ANGLE = 0
var SWORD_LIFE_STEAL = 0
var SIZE = 0
var DAMAGE = 0
var KNOCKBACK = 0


@onready var player = $""

const weapon_offset = 0
var anim : AnimationPlayer
var sprite : AnimatedSprite2D
func _ready():
	# For hits
	connect("body_entered", _on_body_entered)
	
	anim = $AnimationPlayer
	anim.speed_scale = SWING_SPEED * ATTACK_SPEED
	sprite = $AnimatedSprite2D
	
	
func _physics_process(delta: float) -> void:
	

	#SWING
	var event = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if event and not anim.is_playing():
		hitId += 1
		anim.play("swing")
		#print("swung")
	event = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	if event and rate_limit <= 0 and not anim.is_playing():
		#Spawn Projectile
		var projectile = load("res://scenes/bullet.tscn")
		var bullet = projectile.instantiate()
		var game = get_tree().get_root().get_node("Game")
		game.add_child(bullet)
		bullet.global_position = $"AnimatedSprite2D/BarrelExit".global_position
		var rot : float = get_parent().rotation - PI
		# Set Projectile parameters
		bullet.init_vals(rot, self.global_position - last_pos, PROJECTILE_SPREAD)
		last_pos = self.global_position
		rate_limit = 1/(bullet.bps * ATTACK_SPEED)
	else:
		rate_limit -= delta


func _on_body_entered(body) -> void:
	
	if not anim.is_playing():
		return
	#print(body)
	#print("feefee")
	#print("Available methods:", body.get_method_list())
	#print(body.has_method("take_damage"))
	if body.has_method("take_damage"):
		body.take_damage(SWING_DMG * swing_dmg_mod, hitId)
		#print("DAMAAG")
		
func alter_blade(item):
	match item:
		"Knockback":
			return
		"Range":
			return
		"Spread":
			return
		"Crit Chance":
			return
		"Projectile Size":
			return
		
func updateWeapon(stat0, stat1) -> void:
	print(stat0.typeValue, stat1.typeValue)

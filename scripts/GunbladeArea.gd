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
var PROJECTILE_RANGE = 1
var PROJECTILE_SPEED = 1
var SWORD_SWING_ANGLE = 1
var SWORD_LIFE_STEAL = 1
var SIZE = 3
var DAMAGE = 1
var KNOCKBACK = 1


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
		$Swing.play()
		#print("swung")
	event = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	if event and rate_limit <= 0 and not anim.is_playing():
		$Shoot.play()
		#Spawn Projectile
		var projectile = load("res://scenes/bullet.tscn")
		var bullet = projectile.instantiate()
		var game = get_tree().get_root().get_node("Game")
		game.add_child(bullet)
		bullet.global_position = $"AnimatedSprite2D/BarrelExit".global_position
		bullet.get_node("Area2D").proj_dmg_mod = DAMAGE
		bullet.speed *= PROJECTILE_SPEED
		swing_dmg_mod = DAMAGE
		var rot : float = get_parent().rotation - PI
		bullet.get_node("Area2D").knockBack = Vector2(KNOCKBACK,0).rotated(rot)
		bullet.get_node("Area2D/Sprite2D").scale.x *= SIZE
		bullet.get_node("Area2D/Sprite2D").scale.y *= SIZE
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
	var rot : float = get_parent().rotation - PI
	if body.has_method("take_damage"):
		
		body.take_damage(SWING_DMG * swing_dmg_mod, hitId,Vector2(KNOCKBACK,0).rotated(rot))
		#print("DAMAAG")
		
		
func updateWeapon(stat0, stat1) -> void:
	swing_dmg_mod = 1
	PROJECTILE_SPREAD = 1
	PROJECTILE_RANGE = 1
	PROJECTILE_SPEED = 1
	SWORD_SWING_ANGLE = 1
	SWORD_LIFE_STEAL = 1
	SIZE = 1
	DAMAGE = 1
	KNOCKBACK = 1
	for stat in [stat0, stat1]:
		match stat.type:
			DraggableAspect.AspectType.PROJECTILE_RANGE: PROJECTILE_RANGE = stat.typeValue
			DraggableAspect.AspectType.PROJECTILE_SPEED: PROJECTILE_SPEED = stat.typeValue
			DraggableAspect.AspectType.PROJECTILE_SPREAD: PROJECTILE_SPREAD = stat.typeValue
			DraggableAspect.AspectType.SWORD_SWING_ANGLE: SWORD_SWING_ANGLE = stat.typeValue
			DraggableAspect.AspectType.SWORD_LIFE_STEAL: SWORD_LIFE_STEAL = stat.typeValue
			DraggableAspect.AspectType.ATTACK_SPEED: ATTACK_SPEED = stat.typeValue
			DraggableAspect.AspectType.SIZE: SIZE = stat.typeValue
			DraggableAspect.AspectType.DAMAGE: DAMAGE = stat.typeValue
			DraggableAspect.AspectType.KNOCKBACK: KNOCKBACK = stat.typeValue
	print(stat0.typeValue, stat1.typeValue)
	var blade_size = $AnimatedSprite2D
	blade_size.scale.x *= SIZE
	blade_size.scale.y *= SIZE
	

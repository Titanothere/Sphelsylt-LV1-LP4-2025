extends Node2D

const SWING_SPEED = 1
var swing_speed_mod = 1
const weapon_offset = 0
var anim : AnimationPlayer
var sprite : AnimatedSprite2D
var Backpack : Sprite2D 




func addBackpack(backpack):
	Backpack = backpack
	Backpack._on_aspect_update.connect($GunbladeArea.updateWeapon)

func _ready():
	set_process_input(true)
	set_physics_process(true)
	anim = $GunbladeArea/AnimationPlayer
	anim.speed_scale = SWING_SPEED * swing_speed_mod
	sprite = $GunbladeArea/AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	
	# Handle weapon pointing direction
	
	if anim.is_playing():
		return
	var mp : Vector2 = get_global_mouse_position()
	#print(self.global_position)
	var rot : float = atan2((self.global_position.y-mp.y),(self.global_position.x-mp.x)) - PI
	self.rotation = rot
	#print(rot)
	var prev = sprite.flip_v
	if mp.x < self.position.x:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	if prev != sprite.flip_v:
		$GunbladeArea/AnimatedSprite2D/BarrelExit.position.y *= -1

extends Area2D

# Define the base parameters of the weapon
var hitId = 0

const SWING_SPEED = 1
var swing_speed_mod = 1
const SWING_DMG = 1
var swing_dmg_mod = 1

@onready var player = $""

const weapon_offset = 0
var anim : AnimationPlayer
var sprite : AnimatedSprite2D
func _ready():
	# For hits
	connect("body_entered", _on_body_entered)
	
	anim = $AnimationPlayer
	anim.speed_scale = SWING_SPEED * swing_speed_mod
	sprite = $AnimatedSprite2D
	
	
func _physics_process(_delta: float) -> void:
	

	#SWING
	var event = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if event and not anim.is_playing():
		hitId += 1
		anim.play("swing")
		#print("swung")

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

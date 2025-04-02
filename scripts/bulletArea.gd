extends Area2D

const PROJ_DMG : float = 0.5
var proj_dmg_mod : float = 1

func _ready():
	# For hits
	connect("body_entered", _on_body_entered)
	
func _on_body_entered(body) -> void:

	if body.has_method("take_damage"):
		body.take_damage_projectile(PROJ_DMG * proj_dmg_mod)
		queue_free()
		#print("DAMAAG")

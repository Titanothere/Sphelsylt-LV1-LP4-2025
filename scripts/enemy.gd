extends CharacterBody2D
var lastHit = -1
const SPEED = 50
@onready var player = $"../Player"
@export var health = 2
func _physics_process(delta: float) -> void:
	print(delta)
	var angle = player.get_angle_to(self.position)
	
	velocity.x = -cos(angle) * SPEED
	velocity.y = -sin(angle) * SPEED

	move_and_slide()

#
#func _on_sword_body_entered(body: Node2D) -> void:
#	print("collided with", body)
#	if body.scene_file_path.contains("enemy"):
#		body.queue_free()

func take_damage(dmg, hitId) -> void:
	#only damage once each swing
	if hitId == lastHit:
		return
	lastHit = hitId
	self.health -= dmg
	if health <= 0:
		queue_free()

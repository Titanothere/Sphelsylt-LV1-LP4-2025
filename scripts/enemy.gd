extends CharacterBody2D
var lastHit = -1
const SPEED = 50
signal death
@onready var player = $"../Player"
@export var health = 2
const RESPAWN = false
func _physics_process(delta: float) -> void:
	var angle = player.get_angle_to(self.position)
	
	velocity.x = -cos(angle) * SPEED
	velocity.y = -sin(angle) * SPEED

	move_and_slide()

#
#func _on_sword_body_entered(body: Node2D) -> void:
#	print("collided with", body)
#	if body.scene_file_path.contains("enemy"):
#		body.queue_free()
func take_damage_projectile(dmg) -> void:
	self.health -= dmg
	if health <= 0:
		if RESPAWN:
			var enem = load("res://scenes/enemy.tscn")
			var eneme = enem.instantiate()
			var game = get_tree().get_root().get_node("Game")
			game.add_child(eneme)
		queue_free()

func take_damage(dmg, hitId) -> void:
	#only damage once each swing
	if hitId == lastHit:
		return
	lastHit = hitId
	self.health -= dmg
	if health <= 0:
		death.emit()
		queue_free()

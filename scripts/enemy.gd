extends CharacterBody2D
var lastHit = -1
const DRAGFACTOR = 0.5
const ACCELERATION = 150
const SPEED = 50
var bad_fix : float = 0.5
signal death
@onready var player = $"../Player"
@export var health = 2
const RESPAWN = false
func _physics_process(delta: float) -> void:
	bad_fix += delta
	if bad_fix > 0.1:
		$AnimatedSprite2D.play("move")
	var angle = player.get_angle_to(self.position)
	
	var targetVelocity = Vector2(-cos(angle) * SPEED, -sin(angle) * SPEED)
	
	velocity += (targetVelocity - velocity).normalized() * ACCELERATION * delta
	
	velocity = velocity * (DRAGFACTOR ** delta)

	move_and_slide()

#
#func _on_sword_body_entered(body: Node2D) -> void:
#	print("collided with", body)
#	if body.scene_file_path.contains("enemy"):
#		body.queue_free()
func take_damage_projectile(dmg,knockBack) -> void:
	self.health -= dmg
	print("hit!")
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("hurt")
	bad_fix = 0
	print($AnimatedSprite2D.animation)

	if health <= 0:
		if RESPAWN:
			var enem = load("res://scenes/enemy.tscn")
			var eneme = enem.instantiate()
			var game = get_tree().get_root().get_node("Game")
			game.add_child(eneme)
		death.emit()
		queue_free()

func take_damage(dmg, hitId,knockBack) -> void:
	#only damage once each swing
	
	if hitId == lastHit:
		return
	lastHit = hitId
	self.health -= dmg
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("hurt")
	bad_fix = 0
	if health <= 0:
		death.emit()
		queue_free()

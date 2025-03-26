extends CharacterBody2D

const SPEED = 50

@onready var player = $"../Player"

func _physics_process(delta: float) -> void:
	
	var angle = player.get_angle_to(self.position)
	
	velocity.x = -cos(angle) * SPEED
	velocity.y = -sin(angle) * SPEED

	move_and_slide()


func _on_sword_body_entered(body: Node2D) -> void:
	if body.scene_file_path.contains("enemy"):
		body.queue_free()

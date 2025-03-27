extends CharacterBody2D


const SPEED = 100.0
const SQRT2 = 1.414214

func _physics_process(delta: float) -> void:

    # Used to fix "fast diagonals"
	var realSpeed = SPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var hDirection := Input.get_axis("ui_left", "ui_right")
	var vDirection := Input.get_axis("ui_up", "ui_down")

	if hDirection and vDirection:
		realSpeed /= SQRT2

	if hDirection:
		velocity.x = hDirection * realSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, realSpeed)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if vDirection:
		velocity.y = vDirection * realSpeed
	else:
		velocity.y = move_toward(velocity.y, 0, realSpeed)

	move_and_slide()

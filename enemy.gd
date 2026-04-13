extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var direction = -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = direction * SPEED
	
	if is_on_wall():
		direction *= -1
		
	$Sprite2D.flip_h = direction > 0

	move_and_slide()

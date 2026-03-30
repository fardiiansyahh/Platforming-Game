extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -450
const GRAVITY = 900
const DOWN_THRUST = 6000

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

		# Downward thrust (hold ↓)
		if Input.is_action_pressed("ui_down"):
			velocity.y += DOWN_THRUST * delta
			if not $Land_sound.playing :
				$Land_sound.play()

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Jump_Sound.play()

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 4)

	move_and_slide()

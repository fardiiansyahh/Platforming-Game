extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -450
const GRAVITY = 900
const DOWN_THRUST = 6000
const MAX_Jump = 2

var jump_count = 0
var spawn_position = Vector2.ZERO

func ready():
	spawn_position = global_position
	
	
func respawn():
	global_position = spawn_position
	velocity = Vector2.ZERO
	$Death_sound.play()


func _physics_process(delta):
	
	if global_position.y > 1000:
		respawn()	
	
	if is_on_floor() and velocity.y >= 0:
		jump_count = 0
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

		# Downward thrust (hold ↓)
		if Input.is_action_pressed("ui_down"):
			velocity.y += DOWN_THRUST * delta
			if not $Land_sound.playing :
				$Land_sound.play()

	# Jump
	if Input.is_action_just_pressed("ui_up") and jump_count < MAX_Jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		$Jump_Sound.play()

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 4)

	move_and_slide()

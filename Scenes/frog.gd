extends CharacterBody2D

@export var max_jump_hold_sec = 1
const SPEED = 500
const JUMP_VELOCITY = -800
var jump_timer = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity = Vector2.ZERO
		
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_timer += delta
		
	if Input.is_action_just_released("jump") and is_on_floor():
		var jump_strength = min(jump_timer, max_jump_hold_sec)/max_jump_hold_sec
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED * jump_strength
			if(velocity.x < 0):
				$Sprite2D.flip_h = true
			else:
				$Sprite2D.flip_h = false
		velocity.y = JUMP_VELOCITY * jump_strength
		jump_timer = 0

	move_and_slide()

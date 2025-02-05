extends CharacterBody2D

@export var max_jump_hold_sec = 1
@export var MAX_SPEED = 500
@onready var SPEED = MAX_SPEED
const JUMP_VELOCITY = -900
var jump_timer = 0
@export var max_squash_ratio = 0.5
@onready var default_vert_scale = $Sprite2D.scale.y
var jump_strength = 0
var grounded = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		grounded = false
	else:
		velocity = Vector2.ZERO
		if(not grounded):
			$Footsteps.play()
			grounded = true
		
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_timer += delta
		jump_strength = min(jump_timer, max_jump_hold_sec)/max_jump_hold_sec
		$Sprite2D.scale.y = default_vert_scale*(1 - max_squash_ratio*jump_strength)
		
		
	if Input.is_action_just_released("jump") and is_on_floor():
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED * pow(jump_strength, 0.5)
			if(velocity.x < 0):
				$Sprite2D.flip_h = true
				if($Sprite2D/Face.scale.x > 0):
					$Sprite2D/Face.scale.x *= -1
			else:
				$Sprite2D.flip_h = false
				if($Sprite2D/Face.scale.x < 0):
					$Sprite2D/Face.scale.x *= -1
		velocity.y = JUMP_VELOCITY * pow(jump_strength,0.5)
		jump_timer = 0
		$Sprite2D.scale.y = default_vert_scale
		$Ribbit.playing = true

	move_and_slide()

extends CharacterBody2D

@export var max_jump_hold_sec = 1
const SPEED = 500
const JUMP_VELOCITY = -900
var jump_timer = 0
@export var max_squash_ratio = 0.5
@onready var default_vert_scale = $Sprite2D.scale.y
var jump_strength = 0
var grounded = false
@export var ACCEL = 500
@export var tilt_speed = 2
@export var max_tilt = 30

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity().y*delta
		if velocity.y > 0:
			var lift = 0
			if velocity.x > 0:
				pass
			else:
				pass
			lift *= velocity.length()
			velocity += lift
	else:
		velocity = Vector2.ZERO
	
	var tilt_input := Input.get_axis("move_down","move_up")
	$Sprite2D.rotate(tilt_speed*tilt_input*delta)
		
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_timer += delta
		jump_strength = min(jump_timer, max_jump_hold_sec)/max_jump_hold_sec
		$Sprite2D.scale.y = default_vert_scale*(1 - max_squash_ratio*jump_strength)
		
		
	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * pow(jump_strength,0.5)
		jump_timer = 0
		$Sprite2D.scale.y = default_vert_scale

	move_and_slide()

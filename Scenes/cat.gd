extends CharacterBody2D

@export var MAX_SPEED = 300
@onready var SPEED = 300
const JUMP_VELOCITY = -700
var grounded = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$Footsteps.stop()
		grounded = false
	else:
		if(not grounded):
			$Footsteps.play()
			grounded = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if(is_on_floor()):
			$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("RESET")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("RESET")
		$Jump.play()

	move_and_slide()

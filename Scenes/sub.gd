extends CharacterBody2D

@export var MAX_SPEED = 600
@onready var SPEED = MAX_SPEED
var submerged = false

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horz_direction := Input.get_axis("move_left", "move_right")
	var vert_direction := Input.get_axis("move_up","move_down")
	
	if(submerged):
		if horz_direction or vert_direction:
			var desired_velocity = Vector2(horz_direction, vert_direction).normalized() * SPEED
			velocity = velocity.move_toward(desired_velocity, SPEED*delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED*delta)
	else:
		velocity += get_gravity() * delta
	
	move_and_slide()

func submerge(value):
	submerged = value

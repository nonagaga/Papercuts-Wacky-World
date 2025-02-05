extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if get_overlapping_bodies().size() > 0:
		var body = get_overlapping_bodies().front()
		body.SPEED = body.MAX_SPEED/2
		if body.has_method("submerge"):
			body.submerge(true)

func _on_body_exited(body: Node2D) -> void:
	body.SPEED = body.MAX_SPEED
	if body.has_method("submerge"):
			body.submerge(false)

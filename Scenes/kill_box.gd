extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var die_sound : AudioStreamPlayer2D = body.get_node_or_null("Die")
	body.set_physics_process(false)
	if(die_sound):
		die_sound.play()
		die_sound.finished.connect(_on_die_finished.bind(die_sound, body))

func _on_die_finished(die_sound : AudioStreamPlayer2D, body: Node2D):
	body.global_position = Globals.lastCheckpoint
	die_sound.finished.disconnect(_on_die_finished)
	body.set_physics_process(true)
	body.velocity = Vector2.ZERO

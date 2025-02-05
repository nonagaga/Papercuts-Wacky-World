extends Node

var lastCheckpoint = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastCheckpoint = get_tree().get_first_node_in_group("player").global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

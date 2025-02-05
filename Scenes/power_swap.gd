@tool
extends Node2D

enum forms {cat, frog, plane, sub}
@export var power: forms:
	set(new_power):
		power = new_power
		$Viewmodel/PowerSymbol.texture = image_array[power]
@export var image_array : Array[CompressedTexture2D]
@export var scenes_array : Array[PackedScene]

var player_in_body: bool = false
var checkpoint_reached: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Viewmodel/PowerSymbol.texture = image_array[power]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func swap_power(player):
	var new_player: Node2D = scenes_array[power].instantiate()
	new_player.global_position = player.global_position
	var prev_form = forms.get(player.name)
	power = prev_form
	player.call_deferred("queue_free")
	player.add_sibling(new_player)
	PhantomCameraManager.get_phantom_camera_2ds().front().follow_target = new_player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var bodies = $Area2D.get_overlapping_bodies()
		if(bodies.size() > 0):
			var body :CharacterBody2D = bodies.front()
			if body.has_method("submerged") or body.is_on_floor():
				swap_power(bodies.front())


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player") and not checkpoint_reached):
		Globals.lastCheckpoint = global_position
		$AnimationPlayer.play("checkpoint")
		checkpoint_reached = true

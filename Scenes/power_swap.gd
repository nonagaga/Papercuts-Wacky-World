@tool
extends Node2D

@export_enum("Cat", "Frog") var power: int:
	set(new_power):
		power = new_power
@export var image_array : Array[CompressedTexture2D]
@export var scenes_array : Array[PackedScene]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PowerSymbol.texture = image_array[power]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$PowerSymbol.texture = image_array[power]


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

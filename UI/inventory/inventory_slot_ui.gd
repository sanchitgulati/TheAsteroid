
extends Control

@onready var texture_rect: TextureRect = $TextureRect
@onready var data: item_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = data.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

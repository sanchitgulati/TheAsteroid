@tool
extends Area2D

@export var data: item_data
@onready var texture_rect: TextureRect = $TextureRect
@onready var display_name: Label = $Name


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		texture_rect.texture = data.texture
		display_name.text = data.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if texture_rect.texture != data.texture:
			texture_rect.texture = data.texture


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		Inventory.add_item(data)
		visible = false
		#get_tree().root.remove_child(self)
	

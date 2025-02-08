@tool
extends Control

@onready var texture_rect: TextureRect = $PanelContainer/TextureRect

@onready var data: item_data
@onready var item_name: Label = $PanelContainer/ItemName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data != null:
		texture_rect.texture = data.texture
		item_name.text = data.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_pressed() -> void:
	
	pass # Replace with function body.


func _on_button_down() -> void:
	Inventory.drop_item(data)
	pass # Replace with function body.

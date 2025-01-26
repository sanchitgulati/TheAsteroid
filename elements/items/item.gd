extends Area2D

@export var data: item_data
@onready var texture_rect: TextureRect = $TextureRect
@onready var display_name: Label = $Name


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = data.texture
	display_name.text = data.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name == 'Player':
		Inventory.add_item(data)
		visible = false
		get_tree().root
		
	pass # Replace with function body.

@tool
extends Area2D

@export var data: item_data
@onready var texture_rect: TextureRect = $TextureRect
@onready var display_name: Label = $Name
@onready var sprite_shadow: Sprite2D = $SpriteShadow


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data != null and data.texture != null:
		texture_rect.texture = data.texture
		display_name.text = data.name
		sprite_shadow.texture = data.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

#SPENTO PERCHE' ERA IMPOX DEBUGGARE :-(aaa

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if data!=null and data.texture != null and texture_rect.texture != data.texture:
			texture_rect.texture = data.texture
			sprite_shadow.texture = data.texture
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		Inventory.add_item(data)
		Inventory.open()
		#visible = false
		queue_free()
	

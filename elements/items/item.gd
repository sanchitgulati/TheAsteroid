@tool
extends Area2D

class_name Item

@export var data: item_data
@onready var texture_rect: Sprite2D = $Sprite2D
@onready var display_name: Label = $Name



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_from_data()
	pass # Replace with function body.

func set_from_data():
	if data == null: return
	if data.texture == null: return 
	if texture_rect.texture == data.texture: return
	texture_rect.texture = data.texture
	display_name.text = data.name
# Called every frame. 'delta' is the elapsed time since the previous frame.

#SPENTO PERCHE' ERA IMPOX DEBUGGARE :-(aaa

func _process(_delta: float) -> void:
	#if Engine.is_editor_hint():
	set_from_data()
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		Inventory.add_item(data)
		Inventory.open()
		#visible = false
		queue_free()
	

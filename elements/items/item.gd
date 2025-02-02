@tool
extends Area2D

class_name Item

@export var data: item_data
@onready var texture_rect: Sprite2D = $Sprite2D
@onready var display_name: Label = $Name
var player_near: bool


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
	if player_near and not WorldState.PLAYER.auto_interact: 
		
		
		if Input.is_action_just_pressed("interact"):
			pickup()
	pass


func pickup() -> void:
	if not player_near: return 
	Inventory.add_item(data)
	Inventory.open()
	#visible = false
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		player_near = true
		texture_rect.modulate=Color(1,1,0,1)
		if WorldState.PLAYER.auto_interact:
			pickup()


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		player_near = false
		texture_rect.modulate = Color.WHITE

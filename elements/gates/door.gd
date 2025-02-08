extends Node2D
class_name Door

@export var item_unlock: item_data
@export var is_open : bool = false
var status_changed: bool = true

@onready var open: TextureRect = $Open
@onready var close: TextureRect = $Close
@onready var close_collision: CollisionShape2D = $StaticBody2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_door()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_door()
	pass

func update_door():
	if not status_changed: return
	close.visible = !is_open
	open.visible = is_open
	close_collision.disabled = is_open
	
	status_changed = false

func open_door():
	is_open = true
	status_changed = true
	#TODO: play sound
	
func close_door():
	is_open = false
	status_changed = true
	#TODO: play sound

func player_did_touch():
	if is_open: return
	if item_unlock == null:
		open_door()
		return 
		
	if Inventory.contains(item_unlock):
		open_door()
		return 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		player_did_touch()
		
	pass # Replace with function body.

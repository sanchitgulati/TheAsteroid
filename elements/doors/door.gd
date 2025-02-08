extends Node2D
class_name Door

@export var item_unlock: item_data
@export var is_open : bool = false
@export var auto_close: bool = false
var status_changed: bool = true

@onready var open: TextureRect = $open
@onready var close: TextureRect = $close

# close_area
@onready var close_shape: CollisionShape2D = $close_area/close_shape
@onready var interaction_area: Area2D = $interaction_area
# interaction_shape



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_door()
	interaction_area.connect('body_entered',did_enter_area)
	interaction_area.connect('body_exited',did_exit_area)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_door()
	pass

func update_door():
	if not status_changed: return
	close.visible = !is_open
	open.visible = is_open
	close_shape.disabled = is_open
	
	status_changed = false

func open_door():
	is_open = true
	status_changed = true
	#TODO: play sound
	
func close_door():
	is_open = false
	status_changed = true
	#TODO: play sound
	
func is_player(body: Node2D):
	return body.name == 'Player'

func player_did_enter():
	if is_open: return
	if item_unlock == null:
		open_door()
		return 
		
	if Inventory.contains(item_unlock):
		open_door()
		return 

func player_did_leave():
	if !is_open: return
	if !auto_close: return
	if item_unlock == null:
		close_door()
		return 
		
	if Inventory.contains(item_unlock):
		close_door()
		return 

func did_enter_area(body: Node2D) -> void:
	if is_player(body): player_did_enter()
		
	pass # Replace with function body.

func did_exit_area(body: Node2D) -> void:
	if is_player(body): player_did_leave()
		
	pass # Replace with function body.
	

extends Node2D
class_name Door

@export var item_unlock: item_data
@export var is_open : bool = false
@export var auto_close: bool = false
var status_changed: bool = true

@export_enum("Vert Medium", "Hor Medium") var model: String = "Vert Medium"

@onready var open: TextureRect
@onready var close: TextureRect

# close_area
@onready var close_shape: CollisionShape2D
@onready var interaction_area: Area2D
# interaction_shape
@onready var interaction_shape: CollisionShape2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	init_door()
	close_door()
	interaction_area.connect('body_entered',did_enter_area)
	interaction_area.connect('body_exited',did_exit_area)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
#	TODO: è meglio mandare un messaggio broadcast a tutti gli elementi del gruppo "Doors"
	update_door()
	pass

func init_door():
	#	Init Shapes
	match model:
		"Vert Medium":
			print("Vertical Medium Model Selected")
			open = $VertMedOpen
			close = $VertMedClose
			close_shape = $VertMedClose_area/close_shape
			interaction_area = $VertMedInteraction_area
			interaction_shape = $VertMedInteraction_area/interaction_shape
		"Hor Medium":
			print("Horizontal Medium Model Selected")
			open = $HortMedOpen
			close = $HorMedClose
			close_shape = $HorMedClose_area/close_shape
			interaction_area = $HorMedInteraction_area
			interaction_shape = $HorMedInteraction_area/interaction_shape
			
	close_shape.disabled = false
	interaction_shape.disabled = false


func update_door():
	if not status_changed: return
	close.visible = !is_open
	open.visible = is_open
	close_shape.disabled = is_open
	
	status_changed = false

func open_door():
	is_open = true
	status_changed = true
	Sfx.door_open()
	
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
		
#		if conditions are not met play reject sound
	Sfx.door_locked()

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
	

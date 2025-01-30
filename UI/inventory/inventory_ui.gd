extends Control

var is_open = false

var inventory_slot_ui = preload("res://UI/inventory/inventory_slot_ui.tscn")
var slots = []
@onready var grid_container: GridContainer = $GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open: close()
		else: open()
	if Inventory.need_redraw:
		refresh_items()
		Inventory.need_redraw = false

func close():
	print("Inventory CLOSE")
	is_open = false
	visible = false

func open():
	print("Inventory OPEN")
	is_open = true
	visible = true
	

func clear_inventory():
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		

func refresh_items():
	clear_inventory()
	for item in Inventory.items:
		var slot = inventory_slot_ui.instantiate()
		slot.data = item
		grid_container.add_child(slot)
	

extends Node

var item_res = preload("res://elements/items/item.tscn")
var items: Array[item_data] = []
var need_redraw = true
var inventory_ui: Inventory_UI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func item_count():
	return items.size()
	
func contains(item: item_data):
	for inv_item in items: 
		if item == inv_item:
			return true
	return false

func add_item(item: item_data):
	items.append(item)
	need_redraw = true
	Sfx.add_item()
	
func remove_item(item: item_data):
	for itm in items:
		if itm == item:
			items.erase(item)
			need_redraw = true
			Sfx.remove_item()
			break
	pass

func create_ground_item(item:item_data):
	var ground_item = item_res.instantiate()
	ground_item.data = item
	var parent = WorldState.PLAYER.get_parent()
	parent.add_child(ground_item)
	
	ground_item.transform =  WorldState.PLAYER.transform
	
	

func drop_item(item: item_data):
	for inv_item in items:
		if inv_item == item:
			create_ground_item(item)
			remove_item(item)
			need_redraw = true
			break
	pass

func open():
	if inventory_ui == null: return
	inventory_ui.open()
	
func close():
	if inventory_ui == null: return
	inventory_ui.close()
	
func search(item_name: String):
	item_name = item_name.to_lower().strip_edges()
	
	for item in items:
		var slug = item.name.to_lower().strip_edges()
		if name == slug: 
			return item
	
	return null
	

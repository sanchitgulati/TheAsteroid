extends Node

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
	
func remove_item(item: item_data):
	items.erase(item)
	need_redraw = true
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
	

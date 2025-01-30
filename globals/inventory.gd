extends Node

var items: Array[item_data] = []
var need_redraw = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func add_item(item: item_data):
	items.append(item)
	need_redraw = true
	
func remove_item(item: item_data):
	items.erase(item)
	need_redraw = true
	pass
	
	

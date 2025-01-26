extends Control

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open: close()
		else: open()

func close():
	print("Inventory CLOSE")
	is_open = false
	visible = false

func open():
	print("Inventory OPEN")
	is_open = true
	visible = true

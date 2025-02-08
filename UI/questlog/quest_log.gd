extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	toggle_questlog()
	pass

func toggle_questlog():
	if !Input.is_action_just_pressed("questlog"): return
	self.visible = !self.visible
		

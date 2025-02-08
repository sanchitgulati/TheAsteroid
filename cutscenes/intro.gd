extends CanvasLayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if WorldState.debug:
		get_tree().change_scene_to_file("res://main.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

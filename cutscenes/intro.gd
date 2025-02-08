extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("intro_sequence")

func _process(delta: float) -> void:
	if WorldState.debug:
		get_tree().change_scene_to_file("res://main.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

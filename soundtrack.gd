extends Node

@onready var STPlayer: AudioStreamPlayer2D = $Tense

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not WorldState.debug:
		STPlayer.play()

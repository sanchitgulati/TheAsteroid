extends Node

@export var Dialog: Dialogue
@export var Chat: NobodyWhoChat 
@export var Model: NobodyWhoModel 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Chat = $Chat
	Model = $Model
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

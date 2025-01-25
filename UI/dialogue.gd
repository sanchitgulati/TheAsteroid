extends Control


class_name Dialogue

@export var llm_output: Label
@export var llm_input: TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LLM.Dialog = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	


func _on_button_pressed() -> void:
	LLM.Chat.say(LLM.Dialog.llm_input.text)
	pass # Replace with function body.
	pass # Replace with function body.

extends Control


class_name Dialogue

@export var llm_output: Label
@export var llm_input: TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LLM.Dialog = self
	visible=false
	llm_input.text = ""
	llm_output.text = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if visible and Input.is_action_pressed("esc"):
		visible = false
	
	WorldState.PLAYER.can_move = !visible
	
	pass
	

# Button SEND
func _on_button_pressed() -> void:
	LLM.talk_npc(LLM.Dialog.llm_input.text)
	pass # Replace with function body.

 #Button CLOSE
func _on_button_2_pressed():
	pass # Replace with function body.

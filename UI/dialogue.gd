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
	
	if visible:
		if Input.is_action_pressed("esc"): close()
		if Input.is_action_pressed("enter"): talk()
	
	WorldState.PLAYER.can_move = !visible
	
	pass

func clear():
	llm_input.text = ""
	llm_output.text = ""

func open():
	if visible: return
	visible = true
	clear()

func close():
	if not visible: return
	visible = false
	clear()

func talk():

	LLM.talk_npc(LLM.Dialog.llm_input.text)
	llm_input.text = ""

# Button SEND
func _on_button_pressed(): talk()

 #Button CLOSE
func _on_button_2_pressed(): close()

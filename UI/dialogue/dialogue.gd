extends Control


class_name Dialogue

@export var llm_output: RichTextLabel
@export var llm_input: TextEdit
@onready var character_texture: TextureRect = $Character
var npc_data_cur = null
var npc = null

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
		
	if npc_data_cur != null:
		character_texture.texture = npc_data_cur.texture
		if npc != null:
			character_texture.texture = npc.texture_rect.texture
			character_texture.modulate = npc.modulate
		npc_data_cur = null
	else:
		npc = WorldState.current_npc
		if npc != null:
			npc_data_cur = npc.data
	
	
	
	pass

func clear():
	llm_input.text = ""
	llm_output.text = ""

func open():
	WorldState.PLAYER.can_move = false
	
#	TODO: qui deve caricare la texture del char in character_texture
	#character_texture.texture = WorldState.current_npc.texture
	
	
	visible = true
	clear()

func close():
	WorldState.PLAYER.can_move = true
	npc_data_cur = null
	visible = false
	character_texture.texture = null
	Inventory.close()
	clear()

func talk():
	LLM.talk_npc(LLM.Dialog.llm_input.text)
	llm_input.text = ""

# Button SEND
func _on_button_pressed(): talk()

 #Button CLOSE
func _on_button_2_pressed(): close()

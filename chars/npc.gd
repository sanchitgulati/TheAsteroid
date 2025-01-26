@tool 
extends Area2D

class_name NPC


@onready var texture_rect = $TextureRect

@export var npc_info: npc_data
@export var mood:String

var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = npc_info.texture
	LLM.Chat.system_prompt = npc_info.system_prompt
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_area_entered(area: Area2D) -> void:
	if !first_touch : return
	
	print(area.name)
	if area.name=='Player':
		first_touch = false
		LLM.talk_npc("Who are you?", self)
		LLM.Dialog.llm_input.text = "Who are you?"
		
	pass # Replace with function body.


func _on_area_exited(_area: Area2D) -> void:
	first_touch = true
	LLM.clear_npc()
	pass # Replace with function body.

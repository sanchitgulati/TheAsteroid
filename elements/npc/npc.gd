@tool 
extends Area2D

class_name NPC


@onready var texture_rect = $TextureRect

@export var data: npc_data
@export var chat_history: Array[String]

var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = data.texture
	
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_area_entered(area: Area2D) -> void:
	if !first_touch : return
	
	print(area.name)
	if area.name=='Player':
		LLM.Dialog.visible = true
		first_touch = false
		WorldState.set_npc(self)
		LLM.talk_npc("Hello, I'm Kalasnikov")
		#LLM.Dialog.llm_input.text = "Who are you?"
		
	pass # Replace with function body.


func _on_area_exited(_area: Area2D) -> void:
	first_touch = true
	LLM.Dialog.visible = false
	WorldState.clear_npc()
	pass # Replace with function body.

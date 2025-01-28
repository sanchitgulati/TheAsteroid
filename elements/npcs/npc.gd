@tool 
extends Area2D

class_name NPC


@onready var texture_rect = $TextureRect

@export var data: npc_data
@export var chat_history: Array[String]

var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data != null:
		texture_rect.texture = data.texture
	
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	if !first_touch : return
	
	print(body.name)
	if body.name=='Player':
		LLM.Dialog.visible = true
		first_touch = false
		WorldState.set_npc(self)
		LLM.talk_npc("Hello, I'm Inspector Kalashnikov. Who are you and what do you do on The Station?")
#		TODO: bisogna mettere il prompt iniziale dentro il dialog


func _on_body_exited(body: Node2D) -> void:
	first_touch = true
	LLM.Dialog.visible = false
	WorldState.clear_npc()
	pass # Replace with function body.

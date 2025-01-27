extends Node

var current_npc: NPC

var PLAYER:Player

func clear_npc():
	LLM.Chat.system_prompt = ""
	current_npc = null
	
func set_npc(npc:NPC):
	current_npc = npc
	if npc == null or npc.data == null: 
		print("BAD!!!")		
		return
		
	var prompt = npc.data.build_system_prompt()
	LLM.set_system_prompt(prompt)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

extends Node

var last_npc: NPC
var current_npc: NPC

var PLAYER:Player
var quests ={
	"quest_1": 0,
	"quest_2": 0,
	"quest_3": 0
} 

var inventory = [];

func clear_npc():
	LLM.Chat.system_prompt = ""
	current_npc = null
	
func set_npc(npc:NPC):
	last_npc = current_npc
	current_npc = npc
	if npc != null and npc.data != null:
		LLM.Chat.system_prompt = npc.data.build_system_prompt()
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

extends Node

@export var Dialog: Dialogue

@onready var Chat: NobodyWhoChat = $Chat
@onready var Model: NobodyWhoModel  = $Model

var chat_history=[]
var last_answer = ""
var talking = false
var re_newline: RegEx
var lastNPC: NPC

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	re_newline = RegEx.create_from_string("\n\n+")

	
	Chat.start_worker()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	


func talk_npc(prompt: String, npc: NPC ):
	print("-----------------------")
	lastNPC = npc
	if talking: return
	talking = true
	
	Chat.system_prompt = lastNPC.npc_info.system_prompt
	Chat.start_worker()
	#print(Chat.system_prompt)
	
	
	print(prompt)
	chat_history.append(prompt)
	last_answer = ""
	WorldState.PLAYER.can_move = false
	Chat.say(prompt)
	
	
func _on_chat_response_updated(new_token: String) -> void:
	last_answer += new_token
	
	last_answer = re_newline.sub(last_answer, "\n", true)
	Dialog.llm_output.text = last_answer



func _on_chat_response_finished(_response: String) -> void:
	chat_history.append(last_answer)
	print(last_answer)
	talking = false
	Chat.system_prompt = ""
	WorldState.PLAYER.can_move = true

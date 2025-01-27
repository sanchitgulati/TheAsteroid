extends Node

@export var Dialog: Dialogue

@onready var Chat: NobodyWhoChat = $Chat
@onready var Model: NobodyWhoModel  = $Model

var last_answer = ""
var talking = false
var re_newline: RegEx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	re_newline = RegEx.create_from_string("\n\n+")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_system_prompt(prompt:String):
	Chat.system_prompt = prompt
	print("start_worker: begin")
	Chat.start_worker()
	print("start_worker: end")
	

func talk_npc(prompt: String ):
	print("-----------------------")
	if WorldState.current_npc == null: return
	if talking: return
	talking = true
	
	print(prompt)
	WorldState.current_npc.chat_history.append(prompt)
	last_answer = ""
	
	Chat.say(prompt)
	
	
func _on_chat_response_updated(new_token: String) -> void:
	last_answer += new_token
	
	last_answer = re_newline.sub(last_answer, "\n", true)
	Dialog.llm_output.text = last_answer


func _on_chat_response_finished(_response: String) -> void:
	if WorldState.current_npc != null:
		WorldState.current_npc.chat_history.append(last_answer)
	print(last_answer)
	talking = false
	Chat.system_prompt = ""
	LLM.Dialog.llm_input.text = ""

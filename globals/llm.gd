extends Node

@export var Dialog: Dialogue

@onready var Chat: NobodyWhoChat = $Chat
@onready var Model: NobodyWhoModel  = $Model

var last_answer = ""
var talking = false
var re_newline: RegEx
var queue = []

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
	if talking:
		queue.append(prompt)
		return
	talking = true
	
	print(prompt)
	WorldState.current_npc.chat_history.append(prompt)
	if queue.size() == 0:
		Dialog.llm_output.text == ""
	
	Chat.say(prompt)

func process_queue():
	var prompt = queue.pop_front()
	if prompt == null: 
		return false
	talk_npc(prompt)
	return true
	
func _on_chat_response_updated(new_token: String) -> void:
	var cur_answer = Dialog.llm_output.text
	cur_answer += new_token
	cur_answer = re_newline.sub(cur_answer, "\n", true)
	Dialog.llm_output.text = cur_answer


func _on_chat_response_finished(_response: String) -> void:
	if WorldState.current_npc != null:
		WorldState.current_npc.chat_history.append(_response)
	print(_response)
	talking = false
	LLM.Dialog.llm_output.text += '\n---\n'
	if not process_queue():
		LLM.Dialog.llm_input.text = "";
		
	

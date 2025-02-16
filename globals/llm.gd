extends Node

@export var Dialog: Dialogue
@onready var Model: NobodyWhoModel  = $Model

var chat_once: NobodyWhoChat = null 
var last_answer = ""
var talking = false
var re_newline: RegEx
var re_tag:RegEx
var queue = []
var is_chat_ready: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	re_newline = RegEx.create_from_string("\n\n+")
	re_tag = RegEx.create_from_string("<<([A-Z_]+)>>")

func did_init():
	return chat_once != null

func clear_chat():
	if chat_once != null:
		remove_child(chat_once)
		chat_once.queue_free()

func init_chat(prompt:String):
	clear_chat()
	chat_once = NobodyWhoChat.new()
	add_child(chat_once)
	chat_once.model_node = Model
	chat_once.response_updated.connect(_on_chat_response_updated)
	chat_once.response_finished.connect(_on_chat_response_finished)
	
	chat_once.system_prompt = prompt
	chat_once.start_worker()

func talk_npc(prompt: String ):
	#print("talk_npc_queue:", queue.size() )
	if WorldState.current_npc == null: return
	if talking: return
	
	print("-----------------------")
	talking = true
	
	print(prompt)
	WorldState.current_npc.chat_history.append(prompt)
	if queue.size() == 0:
		Dialog.llm_output.text = ""
	
	chat_once.say(prompt)
	
func _on_chat_response_updated(new_token: String) -> void:
	var cur_answer = Dialog.llm_output.text
	cur_answer += new_token
	cur_answer = re_newline.sub(cur_answer, "\n", true)
	cur_answer = check_tags(cur_answer)
	Dialog.llm_output.text = cur_answer


func _on_chat_response_finished(_response: String) -> void:
	if WorldState.current_npc != null:
		WorldState.current_npc.chat_history.append(_response)
	print(_response)
	talking = false
	LLM.Dialog.llm_input.text = ""
	
func check_tags(answer:String):
	var tags_found = re_tag.search_all(answer)
	
	var tags = ['WATER_BOTTLE']
	for tag in tags_found:
		if tags.has(tag.strings[1]):
			var item = preload("res://elements/items/item_data/beer.tres")
			Inventory.open()
			Inventory.add_item(item)
		
	answer = re_tag.sub(answer,"",true)
	return answer
	
	

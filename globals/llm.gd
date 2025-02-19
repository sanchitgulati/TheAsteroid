extends Node

@export var Dialog: Dialogue
@onready var Model: NobodyWhoModel  = $Model

var base_item_path = "res://elements/items/item_data/"

var chat_once: NobodyWhoChat = null 

var summarizer: NobodyWhoChat = null 

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
	cur_answer = check_tags(cur_answer)
	cur_answer = re_newline.sub(cur_answer, "\n", true)
	cur_answer = cur_answer.strip_edges(true, true)
	Dialog.llm_output.text = cur_answer


func _on_chat_response_finished(_response: String) -> void:
	if WorldState.current_npc != null:
		WorldState.current_npc.chat_history.append(_response)
	print(_response)
	talking = false
	LLM.Dialog.llm_input.text = ""
	
func check_tags(answer:String):
	
	
	var tags_found = re_tag.search_all(answer)
	var npc = WorldState.current_npc.data
	
	var interactions = npc.interaction
	var known_tags = {}
	for inter: npc_interaction in interactions:
		known_tags[inter.tag] = inter.reward_item
	
	for tag in tags_found:
		var tag_name = tag.strings[1]
		var item_found = known_tags.get(tag_name)
		if item_found != null:
			# if Inventory.contains(item_found): continue # ONLY ONE
			Inventory.open()
			Inventory.add_item(item_found)
		
	answer = re_tag.sub(answer,"",true)
	return answer
	
	

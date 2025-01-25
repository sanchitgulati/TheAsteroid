extends Node

@export var Dialog: Dialogue
@export var Chat: NobodyWhoChat 
@export var Model: NobodyWhoModel 

var chat_history=[]
var last_answer = ""
var talking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func sayToNPC(prompt: String):
	if talking: return
	talking = true
	
	print(prompt)
	chat_history.append(prompt)
	last_answer = ""
	LLM.Chat.say(prompt)
		
	
func _on_chat_response_updated(new_token: String) -> void:
	last_answer += new_token
	LLM.Dialog.llm_output.text = last_answer
	
	print(".")



func _on_chat_response_finished(_response: String) -> void:
	chat_history.append(last_answer)
	print(last_answer)
	talking = false

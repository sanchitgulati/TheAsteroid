extends Node

@export var Dialog: Dialogue

@onready var Chat: NobodyWhoChat = $Chat
@onready var Model: NobodyWhoModel  = $Model

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
	Chat.say(prompt)
	
	
func _on_chat_response_updated(new_token: String) -> void:
	last_answer += new_token
	Dialog.llm_output.text = last_answer



func _on_chat_response_finished(_response: String) -> void:
	chat_history.append(last_answer)
	print(last_answer)
	talking = false

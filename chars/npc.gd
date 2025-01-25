extends Area2D

var player: Area2D

@onready var nobody_who_chat: NobodyWhoChat = $NobodyWhoChat
@onready var texture_rect = $TextureRect

@export var npc_info: npc_data
@export var mood:String
@export var texture:Texture2D


var chat_history=[]
var last_answer = ""
var talking = false
var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = texture
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_entered(area: Area2D) -> void:
	if !first_touch : return
	
	
	print(area.name)
	if area.name=='Player':
		first_touch = false
		sayToNPC("You: don't touch me!")
	pass # Replace with function body.

func sayToNPC(prompt: String):
	if talking: return
	talking = true
	
	print(prompt)
	chat_history.append(prompt)
	last_answer = ""
	LLM.Chat.say(prompt)
		
	

func _on_nobody_who_chat_response_updated(new_token: String) -> void:
	last_answer += new_token
	LLM.Dialog.llm_output.text = last_answer
	
	print(".")
	pass # Replace with function body.


func _on_nobody_who_chat_response_finished(response: String) -> void:
	chat_history.append(last_answer)
	print(last_answer)
	talking = false
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	first_touch = true
	pass # Replace with function body.

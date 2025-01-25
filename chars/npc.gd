extends Area2D

var player: Area2D

@onready var nobody_who_chat: NobodyWhoChat = $NobodyWhoChat

@export var base_prompt:String
@export var display_name:String
@export var mood:String

var chat_history=[]
var last_answer = ""
var talking = false
var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nobody_who_chat.model_node = LLMModel
	nobody_who_chat.system_prompt = base_prompt
	
	#player = $"../Player"
	pass # Replace with function body.w


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
	nobody_who_chat.say(prompt)
		
	

func _on_nobody_who_chat_response_updated(new_token: String) -> void:
	last_answer += new_token
	print(last_answer)
	
	pass # Replace with function body.


func _on_nobody_who_chat_response_finished(response: String) -> void:
	chat_history.append(response)
	talking = false
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	first_touch = true
	pass # Replace with function body.

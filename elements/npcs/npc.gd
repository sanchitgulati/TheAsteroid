@tool 
extends Area2D

class_name NPC


@onready var texture_rect = $TextureRect

@export var face_opposite : bool = false

@export var data: npc_data
@export var chat_history: Array[String]
@export var talk_begin: bool = false


var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_from_data()
	if face_opposite == true:
		texture_rect.flip_h = true
	
	if data == null: return
	for quest in data.quests:
		if quest == null: continue 
		quest.default_npc = data
		Quests.quests.append(quest)
	pass
	
func equals(npc:NPC):
	return self.data.equals(npc.data)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		set_from_data()
	elif talk_begin: 
		start_talk()
		talk_begin = false
	pass

func set_from_data():
	if data == null: return
	if texture_rect.texture != data.texture:
		texture_rect.texture = data.texture


func _on_body_entered(body: Node2D) -> void:
	if !first_touch : return
	
	print(body.name)
	if body.name=='Player':
		first_touch = false
		WorldState.set_npc(self)
		
		var step = Quests.check_quest(data)
		
		LLM.Dialog.open()
		if Inventory.item_count() > 0:
			Inventory.open()
		
		
		if step != null:
			LLM.Dialog.llm_output.text += '[b]'
			LLM.Dialog.llm_output.text += step.description
			LLM.Dialog.llm_output.text += '[/b]'
		else:
			talk_begin = true
			
			
		
		
			
#		TODO: bisogna mettere il prompt iniziale dentro il dialog

func start_talk():
	var system_prompt = data.build_system_prompt()
	LLM.set_system_prompt(system_prompt)
	var prompt = Prompts.get_prompt('greetings')
	LLM.talk_npc(prompt)



func _on_body_exited(_body: Node2D) -> void:
	first_touch = true
	LLM.Dialog.close()
	WorldState.clear_npc()
	pass # Replace with function body.

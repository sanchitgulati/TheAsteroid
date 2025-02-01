@tool 
extends Area2D

class_name NPC


@onready var texture_rect = $TextureRect

@export var data: npc_data
@export var chat_history: Array[String]

var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_from_data()
	pass
	
func equals(npc:NPC):
	return self.data.equals(npc.data)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		set_from_data()
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
		
		LLM.Dialog.open()
		if Inventory.item_count() > 0:
			Inventory.open()
		
		var quest = Quests.check_quest(self)
		if quest == null:
			var prompt = Prompts.get_prompt('greetings')
			LLM.talk_npc(prompt)
		else:
			Quests.check_step_progress(quest, self)
		
		
			
#		TODO: bisogna mettere il prompt iniziale dentro il dialog

func talk_to(prompt:String):
	LLM.talk_npc(prompt)



func _on_body_exited(_body: Node2D) -> void:
	first_touch = true
	LLM.Dialog.close()
	WorldState.clear_npc()
	pass # Replace with function body.

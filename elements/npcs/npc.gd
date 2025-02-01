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
		
		
		var prompt = Prompts.get_prompt('greetings')
		LLM.talk_npc(prompt)
		
		var found_beer = Inventory.search('beer can')
		if found_beer != null:
			prompt =  "\n"+"You recieved a beer from inspector Kalasnikov. You drink it stright away,\nbecause you are very thirsy.\nYou feel grateful and trusy\n"
			LLM.talk_npc(prompt)
			Inventory.remove_item(found_beer)
			
#		TODO: bisogna mettere il prompt iniziale dentro il dialog


func _on_body_exited(body: Node2D) -> void:
	first_touch = true
	LLM.Dialog.close()
	WorldState.clear_npc()
	pass # Replace with function body.

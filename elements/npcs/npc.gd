@tool 
extends Area2D

class_name NPC


@onready var texture_rect = $TextureRect
@onready var sprite_shadow: Sprite2D = $SpriteShadow

@export var data: npc_data
@export var chat_history: Array[String]
var beer = preload("res://elements/items/item_data/beer.tres")
var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data != null:
		texture_rect.texture = data.texture
		sprite_shadow.texture = data.texture
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if texture_rect.texture != data.texture:
			texture_rect.texture = data.texture
			sprite_shadow.texture = data.texture
	
	pass




func _on_body_entered(body: Node2D) -> void:
	if !first_touch : return
	
	print(body.name)
	if body.name=='Player':
		WorldState.set_npc(self)
		
		LLM.Dialog.open()
		first_touch = false
		
		var prompt = Prompts.greetings
		if Inventory.search('beer'):
			prompt = "Here , take my beer! It's sealed and fresh\n" + prompt
		LLM.talk_npc(prompt)
#		TODO: bisogna mettere il prompt iniziale dentro il dialog


func _on_body_exited(body: Node2D) -> void:
	first_touch = true
	LLM.Dialog.close()
	WorldState.clear_npc()
	pass # Replace with function body.

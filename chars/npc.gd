extends Area2D

class_name NPC

@onready var texture_rect = $TextureRect

@export var npc_info: npc_data
@export var mood:String
@export var texture:Texture2D



var first_touch = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = texture
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_area_entered(area: Area2D) -> void:
	if !first_touch : return
	
	print(area.name)
	if area.name=='Player':
		first_touch = false
		LLM.sayToNPC("You: don't touch me!", self)
		
		
	pass # Replace with function body.


func _on_area_exited(_area: Area2D) -> void:
	first_touch = true
	pass # Replace with function body.

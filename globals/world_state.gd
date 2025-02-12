extends Node

var debug : bool = false

var current_npc: NPC

var PLAYER:Player

func clear_npc():
	current_npc = null
	
func set_npc(npc:NPC):
	current_npc = npc
	if npc == null or npc.data == null: 
		print("BAD!!!")		
		return

func findNPCs(node: Node, result : Array) -> void:
	if node is NPC:
		result.push_back(node)
	for child in node.get_children():
		findNPCs(child, result)

func getScenePublicPersonasPrompts():
	var scene_npc=[]
	var root = get_tree().root
	findNPCs(root, scene_npc)
	
	var prompts = ""
	for npc in scene_npc:
		prompts += npc.data.public_persona + "\n"
	#print(prompts)
	return prompts
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

extends Resource

class_name quest_data

@export var uid: String
@export var active: bool = true
@export var name: String
@export var default_npc: npc_data
@export_multiline var description: String
@export var progress: int = -1
@export var steps: Array[quest_step] = []

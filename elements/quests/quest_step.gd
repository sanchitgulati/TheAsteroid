extends Resource

class_name quest_step

@export_multiline var description = "Description"

@export var step_npc: npc_data
@export var requests: Array[quest_request] = []
@export var rewards: Array[quest_reward] = []

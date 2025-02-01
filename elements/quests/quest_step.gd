extends Resource

class_name quest_step

@export_multiline var description = "Description"

@export var step_npc: npc_data
@export var request_items: Array[item_data] = []
@export var request_npcs: Array[npc_data] = []

@export var rewards_items: Array[item_data] = []
@export var rewards_prompts: Array[prompt_data] = []

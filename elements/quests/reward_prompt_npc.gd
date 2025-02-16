extends quest_reward
class_name reward_prompt_npc

enum prompt_type {
	public_persona,
	private_persona,
	characteristics,
	tone,
	interactions,
	friends,
	enemies,
	current_status
}

@export_multiline var prompt: String
@export var npc: npc_data
@export var replace: bool = false
@export var type: prompt_type

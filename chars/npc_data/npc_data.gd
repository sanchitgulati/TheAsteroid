extends Resource


class_name npc_data

@export var name: String
@export var texture:Texture2D

@export_multiline var base: String
@export_multiline var characteristics: String
@export_multiline var tone: String
@export_multiline var interactions: String
@export_multiline var friends: String
@export_multiline var enemies: String

@export var mood: String
@export var quest_progress: Array[String]


func build_system_prompt():
	var system_prompt: String
	system_prompt = "You live on the asteroid Plutino in the Kuiper Belt. Your life takes place mostly inside The Station: a minerary avampost owned by The Company."

	system_prompt += "Your name is " + name + "\n"

	system_prompt += base + "\n"
	system_prompt += 'Characteristics:' + "\n"
	system_prompt += characteristics  + "\n"
	system_prompt += tone  + "\n"
	system_prompt += interactions  + "\n"
	system_prompt += friends  + "\n"
	system_prompt += enemies + "\n"
	system_prompt += "Your mood is " + mood + ".\n"
	system_prompt += "Now, pretend to be ." + name + ".\n"
	print(system_prompt)
	return system_prompt

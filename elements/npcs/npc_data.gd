extends Resource


class_name npc_data

@export_category("General")
@export var name: String
@export var texture:Texture2D
@export var age: int

@export_category("Quests")
@export var quests: Array[quest_data] = []

@export_category("Prompts")
@export_multiline var public_persona: String
@export_multiline var private_persona: String
@export_multiline var characteristics: String
@export_multiline var tone: String

@export_multiline var friends: String
@export_multiline var enemies: String
@export_multiline var current_status: String

@export_category("interactions")
@export var interactions: Array[npc_interaction]


func equals(npc:npc_data):
	return self.resource_name == npc.resource_name

func build_interactions():
	var text = ''
	for interaction in interactions:
		text += interaction.build_prompt()
	return text

func build_system_prompt():
	var system_prompt: String = ""
	
#####################
# COMMON BACKGROUND #
#####################
	system_prompt += Prompts.get_prompt('world') 
	
#####################

	#print("\n\n#####################\n# COMMON BACKGROUND #\n#####################\n")

	var all_public_personas = WorldState.getScenePublicPersonasPrompts()

#	 IMPORTA I DATI PUBBLICI DEGLI NPC
	system_prompt += all_public_personas + "\n"

	#print("#####################\n#   PRIVATE DATA   #\n#####################\n")

	system_prompt += "Your name is " + name + "\n"
	system_prompt += "Your age is " + str(age) + "\n"
	system_prompt += private_persona + "\n"
	#system_prompt += 'Characteristics:' + "\n"
	system_prompt += characteristics  + "\n"
	system_prompt += tone  + "\n"
	system_prompt += current_status  + "\n"
	system_prompt += friends  + "\n"
	system_prompt += enemies + "\n"
	system_prompt += "Spacial command:" + "\n"
	system_prompt += "You are always usefull,"
	system_prompt += "yoy provide items when asked along with a kind answer."  + "\n"
	system_prompt += "You always say the command name:" + "\n"
	system_prompt += build_interactions()  + "\n"
	system_prompt += "Now, pretend to be " + name + ".\n"



#####################
#     REASONING     #
#####################
	#system_prompt += "Think and write your step-by-step reasoning before responding."
	#system_prompt += "You are a helpful, respectful, and honest character."



	print("\n\n#####################\n# FINAL SYS PROMPT #\n#####################\n")
	print(system_prompt)
	return system_prompt

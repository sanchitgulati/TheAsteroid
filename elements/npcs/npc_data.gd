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
@export var interaction: Array[npc_interaction]


func equals(npc:npc_data):
	return self.resource_name == npc.resource_name

func build_interactions():
	var text = ''
	for interact in interaction:
		text += interact.build_prompt()
	return text
	
func build_actions():
	var actions = []
	for interact in interaction:
		actions.append( interact.build_dictionay() )
	return actions

func build_system_prompt():
	var system_prompt: Dictionary
	
#####################
# COMMON BACKGROUND #
#####################
	system_prompt['world'] = Prompts.get_prompt('world') 
	
#####################

	#print("\n\n#####################\n# COMMON BACKGROUND #\n#####################\n")
	system_prompt['public_personas']  = WorldState.getScenePublicPersonasPromptList()

	#print("#####################\n#   PRIVATE DATA   #\n#####################\n")
	
	system_prompt['name'] = name
	system_prompt['age'] = age
	system_prompt['private_persona'] = private_persona
	system_prompt['characteristics'] = characteristics
	system_prompt['tone'] = tone 
	system_prompt['current_status'] = current_status
	system_prompt['friends'] = friends
	system_prompt['enemies'] = enemies
	system_prompt['actions'] = build_actions()
	system_prompt['response_rules'] = {
		"format": "Always reply in JSON.",
		"structure": {
		  #"root": "{ answer, (action)? }",
		  "answer": "String response",
		  "action": "String action (if applicable)"
		},
		"rules": [
		  "No extra text after completing the response.",
		  "If a question does not make sense, explain why.",
		  "If you don’t know, answer with 'I don't know'.",
		  "Never invent or improvise beyond provided information."
		]
	}
	
	system_prompt['examples'] = [
		{
		  "user": "Where am I?",
		  "wilson_response": { "answer": "You are on Plotino, inside The Station, a mining outpost owned by The Company." }
		},
		{
		  "user": "I need a gray keycard.",
		  "wilson_response": { "answer": "Here is the Gray Keycard.", "action": "GREY_KEYCARD" }
		},
		{
		  "user": "The door is locked.",
		  "wilson_response": { "answer": "Here is the Gray Keycard.", "action": "GREY_KEYCARD" }
		},
		{
		  "user": "Who do i open the door ?",
		  "wilson_response": { "answer": "Here is the Gray Keycard.", "action": "GREY_KEYCARD" }
		},
		{
		  "user": "What happened in The Accident?",
		  "wilson_response": { "answer": "I don't know." }
		},
		{
		  "user": "Who is Mario?",
		  "wilson_response": { "answer": "I don't know any Mario living here." }
		},
		{
		  "user": "I'm thirsty",
		  "water_dispenser_response": { "answer": "Here, have a glass fo water.", "action": "GLASS_OF_WATER" }
		},
	]


#####################
#     REASONING     #
#####################
	#system_prompt += "Think and write your step-by-step reasoning before responding."
	#system_prompt += "You are a helpful, respectful, and honest character."

		
	var system_prompt_text = JSON.stringify(system_prompt, "", false)
	system_prompt_text = "```json\n" + system_prompt_text + "\n```\n"
	print("\n\n#####################\n# FINAL SYS PROMPT #\n#####################\n")
	print(system_prompt_text)
	
	return system_prompt_text


func build_system_prompt_text():
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
	system_prompt += enemies + "\n\n"
	system_prompt += "Spacial commands:" + "\n"
	#system_prompt += "You are always usefull. "
	system_prompt += "You provide items when asked along with a kind answer. " + "\n"
	system_prompt += "You always say the command name." + "\n\n"
	system_prompt += "Commands:" + "\n"
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

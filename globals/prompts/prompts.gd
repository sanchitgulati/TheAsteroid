extends Node
var data_dir = "res://globals/prompts/prompts_data/"
var prompts: Array[Prompt_data]


func _ready() -> void:
	for file_name in DirAccess.get_files_at(data_dir):
		if (file_name.get_extension() == "tres"):
			var res = ResourceLoader.load(data_dir+file_name)
			prompts.append(res)
			pass
	
func get_prompt(name:String):
	for prompt in prompts:
		if prompt.name != name: continue
		if not prompt.active: continue
		return prompt.text
	

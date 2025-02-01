extends Node
var data_dir = "res://globals/prompts/data/"
var prompts: Dictionary


func _ready() -> void:
	for file_name in DirAccess.get_files_at(data_dir):
		if (file_name.get_extension() == "tres"):
			var res = ResourceLoader.load(data_dir+file_name)
			var name = file_name.substr(0,file_name.length()-5)
			name = normalize_name(name)
			res.name = name
			prompts[name]=res
			pass
	
func normalize_name(name:String):
	name = name.to_lower().strip_edges().replace(" ","_")
	return name

func get_prompt(name:String):
	name = normalize_name(name)
	var prompt = prompts[name] 
	if prompt == null: return 
	
	var output = ""
	for part in prompt.list:
		if not part.active: continue
		output += part.text
	
	return output
	

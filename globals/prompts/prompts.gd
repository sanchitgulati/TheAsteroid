extends Node
var data_dir = "res://globals/prompts/data/"
var prompts: Dictionary


func _ready() -> void:
	for file_name in DirAccess.get_files_at(data_dir):
		if (file_name.get_extension() == "tres"):
			var res = ResourceLoader.load(data_dir+file_name)
			var slug = file_name.substr(0,file_name.length()-5)
			slug = normalize_name(slug)
			res.name = slug
			prompts[slug]=res
			pass
	
func normalize_name(dirty_name:String):
	dirty_name = dirty_name.to_lower().strip_edges().replace(" ","_")
	return dirty_name

func get_prompt(slug:String):
	slug = normalize_name(slug)
	var prompt = prompts[slug] 
	if prompt == null: return 
	
	var output = ""
	for part in prompt.list:
		if not part.active: continue
		output += part.text
	
	return output
	

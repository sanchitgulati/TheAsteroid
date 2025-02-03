extends Node
var data_dir = "res://globals/prompts/data/"
var prompts: Dictionary


func _ready() -> void:
	print('promps ready')
	for file_name in DirAccess.get_files_at(data_dir):
		print('file_name: ', file_name, ' ', file_name.get_extension(), '\n')
		
		if (file_name.get_extension() == "remap"):
			file_name = file_name.substr(0,file_name.length()-6)
		
		if (file_name.get_extension() == "tres"):
			print('file_name: valid: ', file_name)
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
	print("prompts:slug:", slug)
	slug = normalize_name(slug)
	if not prompts.has(slug):
		print('get_prompt:not found: ', slug, prompts)
		return
	
	var prompt = prompts[slug] 
	if prompt == null: return 
	
	var output = ""
	for part in prompt.list:
		if not part.active: continue
		output += part.text
	
	return output
	

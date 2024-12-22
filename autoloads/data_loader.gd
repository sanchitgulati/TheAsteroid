extends Node

const ASSET_DIR = "res://assets/"
const PROMPT_DIR = "res://assets/prompts/"

var prompt_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir = DirAccess.open(PROMPT_DIR)
	var files = dir.get_files()
	if files.ends_with('.json'):
		
	print(files)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Resource


class_name npc_interaction

@export_category("General")

const tag_open = '<<'
const tag_close = '>>'

@export var tag: String
@export var reward_item: item_data
@export_multiline var prompt:String


func build_prompt():
	var text = ''
	text += tag_open + tag + tag_close
	text += prompt + '\n' 
	return text

extends Resource

class_name quest_data

@export var uid = "quest_1"
@export var name = "Quest di Benno"
@export_multiline var description = "Description"
@export var progress: int
@export var steps: Array[quest_step] = []
@export var begin_with: Array[quest_requirement]=[]

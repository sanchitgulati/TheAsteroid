extends Resource


class_name quest_requirement

enum match_mode {QUEST_DONE, ITEM_FOUND, PERSON_SPOKE, LOCATION}

@export var match_type: match_mode
@export var match_quest: quest_data
@export var match_item: item_data
@export var match_person: npc_data
@export var location: Vector2
@export var location_distance: float

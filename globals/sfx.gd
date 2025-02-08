extends Node

var rng = RandomNumberGenerator.new()

@onready var add_item_sound: AudioStreamPlayer = $AddItemSound
@onready var remove_item_sound: AudioStreamPlayer = $RemoveItemSound
@onready var door_open_sound: AudioStreamPlayer = $DoorOpenSound
@onready var finish_quest_sound: AudioStreamPlayer = $FinishQuestSound



func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = Time.get_unix_time_from_system()

func add_item():
	add_item_sound.play()
	
func remove_item():
	remove_item_sound.play()
	
func door_open():
	door_open_sound.play()

func finish_quest():
	finish_quest_sound.play()

extends Node

@export var quests: Array[quest_data] = []

var data_dir = "res://elements/quests/quest_data/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_quests()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func load_quests() -> void:
	for file_name in DirAccess.get_files_at(data_dir):
		if (file_name.get_extension() == "remap"):
			file_name = file_name.substr(0,file_name.length()-6)
		
		if (file_name.get_extension() == "tres"):
			var path  = data_dir+file_name
			var res =  load(path) 
			#var res = ResourceLoader.load(path) as quest_data
			if not res.active: continue
			quests.append(res)


func check_quest(current_npc: npc_data):
	var next_quest = get_next_quest(current_npc)
	var next_step: quest_step = null
	if next_quest != null:
		next_step = current_quest_step(next_quest)
		start_quest(next_quest)
		next_step = check_step_progress(next_quest, current_npc)
		return next_step
	
	var open = get_open_quests(current_npc)
	if open.size() > 0:
		var current = open[0]
		next_step = check_step_progress(current, current_npc)
		return next_step
	
	return next_step
	
func start_quest(quest:quest_data):
	if quest.progress >= 0: return
	quest.progress = 0

func get_next_quest(current_npc: npc_data):
	for quest in quests:
		var data_npc = quest_npc(quest)
		if data_npc != current_npc: continue
		
		if quest.progress != -1: continue
		if not check_step_requests(quest): continue  
		return quest

func get_open_quests(current_npc: npc_data):
	var open = []
	for quest in quests:
		var data_npc = quest_npc(quest)
		if data_npc != current_npc: continue
		if quest.progress < 0: continue
		if quest.progress >= quest.steps.size(): continue
		open.append(quest)
	return open
	
func quest_npc(quest:quest_data):
	var step = current_quest_step(quest)
	var npc = quest.default_npc if step == null or step.step_npc == null else step.step_npc
	return npc
	
func check_step_progress(quest:quest_data, current_npc: npc_data):
	var cur_step = current_quest_step(quest)
	if cur_step == null: return null
		
	if not check_step_requests(quest): return null
	take_requests(cur_step)
	give_rewards(cur_step)
	quest.progress += 1
	return cur_step

func take_requests(step:quest_step):
	for item in step.requests:
		if item is item_data:
			Inventory.remove_item(item)
			print("take_request: ", item.name)

func give_rewards(step:quest_step):
	for reward in step.rewards:
		if reward is reward_item:
			Inventory.add_item(reward.item)
			print("give_reward: ", reward.item.name)

func current_quest_step(quest: quest_data):
	if quest.progress>=quest.steps.size(): return null 
	var progress = 0 if quest.progress < 0 else quest.progress
	var cur_step = quest.steps[progress]
	return cur_step

func check_step_requests(quest: quest_data):
	var cur_step = current_quest_step(quest)
	if cur_step == null: return false
	
	var items_ok = check_step_items(cur_step)
	
	return items_ok

func check_step_items(step:quest_step):
	var found = true
	for item in step.requests:
		if item is item_data:
			found = found and Inventory.contains(item)
	
	return found

		

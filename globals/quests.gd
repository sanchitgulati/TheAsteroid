extends Node

@export var quests: Array[quest_data] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func check_quest(current_npc: npc_data):
	var next_quest = get_next_quest(current_npc)
	if next_quest != null:
		start_quest(next_quest)
		return next_quest
	
	var open = get_open_quests(current_npc)
	if open.size() > 0:
		var current = open[0]
		check_step_progress(current, current_npc)
		return current
	
func start_quest(quest:quest_data):
	if quest.progress >= 0: return
	quest.progress = 1

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
	if cur_step == null: return false
		
	if not check_step_requests(quest): return false
	take_requests(cur_step)
	give_rewards(cur_step)
	quest.progress += 1
	return true
	

func take_requests(step:quest_step):
	for item in step.request_items:
		Inventory.remove_item(item)
		print("take_request", item.name)
	

func give_rewards(step:quest_step):
	for item in step.rewards_items:
		Inventory.add_item(item)
		print("give_reward", item.name)

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
	for item in step.request_items:
		found = found and Inventory.contains(item)
	return found

		

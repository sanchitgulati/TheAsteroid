extends Control

var need_update_quests = true
var need_update_text = true
var quests_open: Array[quest_data]
var quests_completed: Array[quest_data]
var show_completed = false
@onready var content: RichTextLabel = $Answer/MarginContainer/content

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	update_quests()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	toggle_questlog()
	update_quests()
	show_quests()
	pass

func toggle_questlog():
	if !Input.is_action_just_pressed("questlog"): return
	self.visible = !self.visible
	need_update_quests = true
		
func update_quests():
	if not need_update_quests: return 
	quests_open = Quests.get_open_quests()
	quests_completed = Quests.get_completed_quests()
	need_update_quests = false
	need_update_text	 = true
	
	
func show_quests():
	if not need_update_text: return 
	var quests_list = quests_open
	if show_completed:
		quests_list = quests_completed
	
	content.text = ""
	for quest in quests_list:
		content.text += "[b][u]"+quest.name+"[/u][/b]"+"\n"
		var step = 0
		while step < quest.progress:
			var cur_step = quest.steps[step] as quest_step
			#content.text += "[b]*[/b] " 
			content.text += 	("%2d. " % (step+1) )
			content.text += cur_step.description.strip_edges() +"\n"
			var total = cur_step.requests.size() + cur_step.rewards.size()
			
			for reward in cur_step.rewards:
				if reward is reward_item:
					var item = reward.item as item_data # todo
					content.text += "+" + item.name + " "
					
			for requests in cur_step.requests:
				if requests is item_data:
					var item = requests as item_data # todo
					content.text += "-" + item.name + " "
			
			if total>0: content.text += "\n"
					
			step += 1
		content.text += "\n"
	need_update_text = false

func _on_quest_open_button_down() -> void:
	show_completed = false
	need_update_text = true
	pass # Replace with function body.


func _on_quest_completed_button_down() -> void:
	show_completed = true
	need_update_text = true
	pass # Replace with function body.

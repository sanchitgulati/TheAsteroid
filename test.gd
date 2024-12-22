extends Node2D

@onready var llm_engine: GDLlama = $llm_engine
@onready var llm_output: RichTextLabel = $Control/VBoxContainer/llm_output
@onready var llm_input: TextEdit = $Control/VBoxContainer/llm_input


func _ready():
	print(Time.get_datetime_string_from_system())
	llm_engine.model_path = "./models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf" ##Your model path
	llm_engine.n_predict = 200
	llm_engine.instruct = false
	llm_engine.should_output_prompt = false
	llm_engine.should_output_special = false
	llm_engine.context_size = 2024
	llm_engine.main_gpu = 1
	
	
	llm_input.text = 'ciao, chi sei ?'
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_send_pressed() -> void:
	print(Time.get_datetime_string_from_system())
	
	var benno_init = DataLoader.benno_init
	var benno_init_json = DataLoader.benno_init_json
	
	#llm_engine.input_prefix = benno_init
	llm_output.text = ""
	var prompt = benno_init + "\n\n" + llm_input.text
	#var prompt = llm_input.text
	llm_engine.run_generate_text(prompt,"",benno_init_json)
	
	
	
	print(Time.get_datetime_string_from_system())
	
	pass # Replace with function body.


func _on_llm_engine_generate_text_updated(new_text: String) -> void:
	llm_output.text += new_text
	pass # Replace with function body.

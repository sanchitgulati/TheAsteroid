extends Node2D

@onready var llm_engine: GDLlama = $llm_engine
@onready var llm_output: RichTextLabel = $Control/VBoxContainer/llm_output
@onready var llm_input: TextEdit = $Control/VBoxContainer/llm_input


func _ready():
	print(Time.get_datetime_string_from_system())
	llm_engine.model_path = "./models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf" ##Your model path
	llm_engine.n_predict = 200
	#llm_engine.instruct = true
	llm_engine.should_output_prompt = false
	llm_engine.should_output_special = false
	llm_engine.context_size = 1024
	
	llm_input.text = 'ciao, chi sei ?'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_send_pressed() -> void:
	print(Time.get_datetime_string_from_system())
	
	var benno_init = DataLoader.benno_init
	
	#llm_engine.input_prefix = benno_init
	
	var prompt = benno_init + "\n\n" + llm_input.text
	var generated_text = llm_engine.generate_text_simple( prompt )
	llm_output.text = generated_text
	
	
	print(Time.get_datetime_string_from_system())
	
	pass # Replace with function body.

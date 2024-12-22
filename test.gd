extends Node2D

@onready var llm_engine: GDLlama = $llm_engine
@onready var llm_input: TextEdit = $HBoxContainer/llm_input
@onready var llm_output: RichTextLabel = $HBoxContainer/llm_output

func _ready():
	print(Time.get_datetime_string_from_system())
	llm_engine.model_path = "./models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf" ##Your model path
	llm_engine.n_predict = 20
	


	print(Time.get_datetime_string_from_system())
	var generated_text = llm_engine.generate_text_simple(llm_input.)
	print(generated_text)
	print(Time.get_datetime_string_from_system())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

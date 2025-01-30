# Sperimentale, per mettere dentro npc_data una serie di stringhe accendibili e spegnibili a piacimento

extends Node

@export var composers: Array[ComposerEntry] = []

# Helper function to create and configure a ComposerEntry
func create_composer(is_checked: bool, text: String) -> ComposerEntry:
	var composer = ComposerEntry.new()
	composer.is_checked = is_checked
	composer.text = text
	return composer

func _ready():
	# Initialize the composers array with properly set objects
	composers = [
		create_composer(true, "Mozart"),
		create_composer(false, "Beethoven"),
		create_composer(true, "Bach")
	]

	# Test the function that concatenates checked entries with indentation
	var indented_text = concatenate_checked_strings_with_indentation()
	print(indented_text)

# Concatenate strings of checked composers with indentation
func concatenate_checked_strings_with_indentation() -> String:
	var result: String = ""
	for composer in composers:
		if composer.is_checked:
			result += "\t" + composer.text + "\n"  # Indent with a tab and add a newline
	return result.strip_edges()  # Remove the trailing newline or tabs

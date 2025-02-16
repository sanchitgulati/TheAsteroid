extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		print("Fade Out")
		animation_player.play("fade_out")
		
func _on_animation_finished(anim_name: String
):
		print("Destroy Self and Children!")
		queue_free()

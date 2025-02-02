extends CharacterBody2D

class_name Player
# to add Animation check:
# https://docs.godotengine.org/en/stable/getting_started/first_2d_game/03.coding_the_player.html
@export var speed : float = 300.0  # Movement speed
@export var acceleration : float = 500.0  # Smooth acceleration
@export var friction : float = 500.0  # Friction when stopping
@export var auto_interact:bool = true
var direction := Vector2.ZERO

var screen_size # Size of the game window.
var can_move = true


func _ready():
	WorldState.PLAYER = self
	screen_size = get_viewport_rect().size
	#var screen_center = Vector2(screen_size.x/2, screen_size.y/2)
	#position = screen_center

func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed

func _physics_process(_delta):
	if !can_move: return
	get_input()
	#move_and_collide(velocity * delta)

	## Move and slide
	move_and_slide()

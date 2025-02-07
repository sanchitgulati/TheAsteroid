extends CharacterBody2D

class_name Player

@export var speed : float = 300.0  # Movement speed
@export var acceleration : float = 500.0  # Smooth acceleration
@export var friction : float = 500.0  # Friction when stopping
@export var auto_interact:bool = true

var direction := Vector2.ZERO
var can_move = true

var screen_size # Size of the game window.

# Anim section
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_shadow: AnimatedSprite2D = $AnimatedSprite2DShadow

var face_direction : String = "down"
var animation_to_play := "idle_down"


func _ready():
	WorldState.PLAYER = self
	screen_size = get_viewport_rect().size
	#var screen_center = Vector2(screen_size.x/2, screen_size.y/2)37.7
	#position = screen_center

func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed



func _physics_process(_delta):
	
	if !can_move: return
	
	# Get raw input
	var raw_input :=  Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Set appropriate velocity
	velocity =  raw_input * speed

	# Since we're using 360 degree movement now, we can't assume assume vertical motion should always take priority. So we figure out the biggest direction.
	if raw_input.length() > 0: # Check if we're moving
		if abs(raw_input.x) > abs(raw_input.y): # Horizontal or vertical? (prioritizing vertical movement)
			face_direction = "left" if raw_input.x < 0 else "right"
		else:
			face_direction = "up" if raw_input.y < 0 else "down"
	
	# All movement animations named appropriately, eg "Left_Idle" or "Back_Walk"
	animation_to_play =  ("walk" if velocity.length() > 0.0 else "idle") + "_" + face_direction
	#print("Player anim: " + animation_to_play)
	animated_sprite.play(animation_to_play)
	animated_shadow.play(animation_to_play)
	
	## Move and slide
	move_and_slide()

extends CharacterBody2D


class_name Player
# to add Animation check:
# https://docs.godotengine.org/en/stable/getting_started/first_2d_game/03.coding_the_player.html
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var can_move = true

func _ready():
	WorldState.PLAYER = self
	screen_size = get_viewport_rect().size
	#var screen_center = Vector2(screen_size.x/2, screen_size.y/2)
	#position = screen_center

func _process(delta):
	if !can_move: return
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	else:
		pass
		#$AnimatedSprite2D.stop()
		
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)

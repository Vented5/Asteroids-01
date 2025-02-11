extends Area2D

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_forward"):
		velocity = Vector2(0, -1).rotated(rotation) 
	
	if Input.is_action_pressed("move_backwards"):
		velocity = Vector2(0, +1).rotated(rotation)
	
	if Input.is_action_pressed("rotate_right"):
		rotate(0.1)
	
	if Input.is_action_pressed("rotate_left"):
		rotate(-0.1)
	
	
	position += velocity * delta * speed
	position = position.clamp(Vector2.ZERO, screen_size)

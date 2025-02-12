extends Area2D

@export var speed = 200
@export var rotation_speed = 0.1

@export var bullet_scene : PackedScene
var shoot_cooldown = true

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_forward"):
		velocity = Vector2(0, -1).rotated(rotation) 
	
	if Input.is_action_pressed("move_backwards"):
		velocity = Vector2(0, +1).rotated(rotation)
	
	if Input.is_action_pressed("rotate_right"):
		rotate(rotation_speed)
	
	if Input.is_action_pressed("rotate_left"):
		rotate(-rotation_speed)
	
	if Input.is_action_pressed("shoot") and shoot_cooldown:
		var bullet1 = bullet_scene.instantiate()
		var bullet2 = bullet_scene.instantiate()
		owner.add_child(bullet1)
		owner.add_child(bullet2)
		bullet1.transform = $Cannon1.global_transform
		bullet2.transform = $Cannon2.global_transform
		shoot_cooldown = false
		$Fire_rate.start()
	
	position += velocity * delta * speed
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_fire_rate_timeout():
	shoot_cooldown = true

extends Node


@export var asteroid_s_scene: PackedScene
@export var asteroid_m_scene: PackedScene
@export var asteroid_l_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$AsteroidTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_asteroid_timer_timeout():
	var random = randi_range(1, 3)
	var asteroid
	
	if random == 1:
		asteroid = asteroid_s_scene.instantiate() # Instantiate the scene
	elif random == 2:
		asteroid = asteroid_m_scene.instantiate() # Instantiate the scene
	elif random == 3:
		asteroid = asteroid_l_scene.instantiate() # Instantiate the scene
	
	
	# Picks a random location along the asteroid path
	var asteroid_spawn_location = $AsteroidPath/AsteroidPathLocation
	asteroid_spawn_location.progress_ratio = randf()
	
	# Sets the direciton perpendicular to the screen border
	var direction = asteroid_spawn_location.rotation + PI / 2
	
	# Sets asteroid position at a random location
	asteroid.position = asteroid_spawn_location.position 
	
	# Add som randomness to the direction
	direction += randf_range(-PI / 4, PI / 4)
	asteroid.rotation = direction 
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	add_child(asteroid)

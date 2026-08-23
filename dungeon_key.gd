extends Node3D

var spin_speed = 2.0
var float_speed = 3.0
var float_height = 0.2

var start_y = 0.0
var time_passed = 0.0 

func _ready() -> void:
	# key placement
	start_y = position.y

func _process(delta: float) -> void:
	# rotation
	rotate_y(spin_speed * delta)
	# float
	time_passed += delta
	position.y = start_y + (sin(time_passed * float_speed) * float_height)

func _on_body_entered(body: Node3D) -> void: 
	if body.name == "Player":
		body.has_space_key += 1
		print("space key picked:", body.has_space_key)
		queue_free()

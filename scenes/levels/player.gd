extends CharacterBody3D

@export var base_speed := 4.0

@onready var camera = $"camera controller/Camera3D"

var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	movement_input = Input.get_vector("ui_down","ui_up","ui_left","ui_right")
	velocity = Vector3(movement_input.x,0,movement_input.y) * base_speed
	move_and_slide()
	print(camera.global_rotation.y)
	

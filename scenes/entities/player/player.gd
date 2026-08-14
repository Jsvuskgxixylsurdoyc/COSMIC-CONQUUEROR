extends CharacterBody3D

#jump
@export var jump_height : float = 2.25


@export var base_speed := 4.0

@onready var camera = $Cameracontroller/Camera3D

var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	movement_input = Input.get_vector("ui_left","ui_right","ui_up","ui_down").rotated(-camera.global_rotation.y)
	#velocity = Vector3(movement_input.x,0,movement_input.y) * base_speed
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = 40
	velocity.y -= 0.5
	
	move_and_slide()
	

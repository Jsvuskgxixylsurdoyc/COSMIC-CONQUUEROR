extends Node3D

@export var min_limit_x: float = -1.5
@export var max_limit_x: float = 1.5
@export var horizontal_accelaration := 2.0
@export var vertical_accelaration := 1.0
@export var mouse_accelaration := 0.005



#func _process(delta: float) -> void:
	#var joy_dir = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	#rotate_from_vector(joy_dir * delta * Vector2(horizontal_accelaration, vertical_accelaration))
	
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * mouse_accelaration)

func rotate_from_vector(v: Vector2):
	if v.length() ==  0: return
	rotation.y -= v.x 
	rotation.x -= v.y
	rotation.x =clamp(rotation.x, min_limit_x, max_limit_x)
	
	
	
	

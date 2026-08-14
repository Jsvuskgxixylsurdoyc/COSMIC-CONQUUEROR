extends Node3D

@export var horizontal_acceleration := 2.0
@export var vertical_acceleration := 2.0

func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * 0.005)


func rotate_from_vector(v: Vector2):
	if v.length() == 0: return
	rotation.y += v.x
	

 
	 

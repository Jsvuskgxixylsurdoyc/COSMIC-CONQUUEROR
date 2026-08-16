extends CharacterBody3D



@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))

@onready var skin =$godetteskin


@export var base_speed := 4.0
@export var run_speed := 6.0
@export var defend_speed := 2.0
@onready var camera = $Cameracontroller/Camera3D

var movement_input := Vector2.ZERO
var defend :=false:
	set(value):
		if not defend and value:
			skin.defend(true)
		if defend and not value:
			skin.defend(false)
		defend = value
var weapon_active := false


func _physics_process(delta: float) -> void:
	
	move_logic(delta)
	jump_logic(delta)
	ability_logic()
	if Input.is_action_just_pressed("ui_accept"):
		skin.hit()
	move_and_slide()
	
func move_logic(delta) -> void:
	movement_input = Input.get_vector("ui_left","ui_right","ui_up","ui_down").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	var is_running: bool = Input.is_action_pressed("run")
	
	if movement_input != Vector2.ZERO:
		var speed = run_speed if is_running else base_speed
		speed = defend_speed if defend  else speed
		
		vel_2d += movement_input * speed * delta * 8.0
		vel_2d = vel_2d.limit_length(speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		skin.set_move_state('running')
		var target_angle = -movement_input.angle() + PI/2
		skin.rotation.y = rotate_toward(skin.rotation.y, target_angle, 6.0 * delta)
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * 4.0 * delta)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		skin.set_move_state('Idle')
	
func jump_logic(delta) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity
		$godetteskin.set_move_state('jump')
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y += gravity * delta
	
	
func ability_logic() -> void:
	  #actual attack
	if Input.is_action_just_pressed("ability"):
		if weapon_active:
			skin.attack()
		else:
			skin.cast_spell()
	
	#defend
	defend = Input.is_action_pressed("block")
	
	#switch weapon/magic
	if Input.is_action_just_pressed("switch weapon"):
		weapon_active = not weapon_active
		skin.switch_weapon(weapon_active)

func do_squash_and_strech(value: float, duration: float = 0.1):
	var tween = create_tween()
	tween.tween_property(skin, "squash_and_strech", value, duration)

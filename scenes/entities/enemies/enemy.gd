class_name Enemy
extends CharacterBody3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var attack_animation = $AnimationTree.get_tree_root().get_node('AttackAnimation')
@onready var player = get_tree().get_first_node_in_group('Player')
@onready var skin = get_node('skin')

@export var walk_speed := 2.0
@export var speed = walk_speed
var speed_modifier := 1.0
@export var notice_radius := 30.0
@export var attack_radius := 3.0

var rng = RandomNumberGenerator.new()

func move_to_player(delta):
	var boss_pos2d = Vector2(global_position.x, global_position.z)
	var player_pos2d = Vector2(player.global_position.x, player.global_position.z)
	var flat_distance = boss_pos2d.distance_to(player_pos2d)
	
	# 1.Are we inside the notice zone?
	if flat_distance < notice_radius:
		
		var target_dir = (player.global_position- global_position).normalized()
		var target_vec2 = Vector2(target_dir.x,target_dir.z).normalized()
		
		var target_angle = -target_vec2.angle() + PI/2
		rotation.y = rotate_toward(rotation.y, target_angle, delta * 6.0)

		# 2. Are we outside attack range?
		if flat_distance > attack_radius:
			velocity = Vector3(target_vec2.x, 0, target_vec2.y) * speed * speed_modifier
			
			if velocity == Vector3.ZERO:
				move_state_machine.travel('idle')
			else:
				move_state_machine.travel('walk')
				
				#3. We are inside attack range !
		else:
			velocity = Vector3.ZERO
			move_state_machine.travel('idle')

		move_and_slide()

func stop_movement(start_duration: float, end_duration: float):
	var tween = create_tween()
	tween.tween_property(self, "speed_modifier", 0.0, start_duration)
	tween.tween_property(self, "speed_modifier", 1.0, end_duration)
	
	

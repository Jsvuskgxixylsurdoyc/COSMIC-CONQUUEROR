extends Enemy

const simple_attacks = {
	'slice' : "2H_Melee_Attack_Slice",
	'spin' : "2H_Melee_Attack_Spin" ,
	'range' : "1H_Melee_Attack_Stab" ,
}
@export var spin_speed = 6
var can_damage_toggle := false

func _process(delta: float) -> void:
	attack_logic()
func _physics_process(delta: float) -> void:
	move_to_player(delta)


func _on_attacktimer_timeout() -> void:
	var dist = position.distance_to(player.position)
	
	if dist < 5.0:
		melee_attack_animation()
	elif dist < 30.0: # This stops the boss from shooting if you run away!
		range_attack_animation()
	else:
		pass
func spin_attack_animation() -> void:
	var tween = create_tween()
	tween.tween_property(self, "speed", spin_speed, 0.5)
	tween.tween_method(_spin_transition, 0.0, 1.0, 0.3)

func _spin_transition(value: float) -> void:
	$AnimationTree.set("parameters/SpinBlend/blend_amount", value)

func range_attack_animation() -> void:
	stop_movement(1.5,1.5)
	attack_animation.animation = simple_attacks['range']
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)



func  melee_attack_animation() ->void:
	attack_animation.animation = simple_attacks['slice' if rng.randi() % 2 else 'spin']
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	


func hit():
	if not $timers/InvulTimer.time_left:
		print('boss was hit')
		$timers/InvulTimer.start()
		
		
func can_damage(value: bool) -> void:
	can_damage_toggle = value
	
	
	
func attack_logic() -> void:
	if can_damage_toggle:
		var collider = $skin/Rig/Skeleton3D/Nagonford_Axe/Nagonford_Axe/RayCast3D.get_collider()
		if collider and 'hit' in collider:
			collider.hit()

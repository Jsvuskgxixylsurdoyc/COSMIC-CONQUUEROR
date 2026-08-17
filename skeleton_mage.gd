extends Enemy

func _ready() -> void:
	attack_radius = 10.0
	
func _physics_process(delta: float) -> void:
	move_to_player(delta)


func _on_attacktimer_timeout() -> void:
	$timers/Attacktimer.wait_time = rng.randf_range(2.0, 3.0)
	if position.distance_to(player.position) < attack_radius:
		$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

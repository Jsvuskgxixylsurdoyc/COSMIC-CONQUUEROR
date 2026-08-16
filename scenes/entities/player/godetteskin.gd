extends Node3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var extra_animation = $AnimationTree.get_tree_root().get_node('ExtraAnimation')
var attacking := false
var squash_and_strech := 1.0:
	set(value): 
		squash_and_strech = value
		scale = Vector3(1,squash_and_strech,1)

func set_move_state(state_name: String) -> void:
	move_state_machine.travel(state_name)


func attack() -> void:
	# Just fire the single animation, no complex math or toggles!
	if not $AnimationTree.get("parameters/AttackOneShot/active"):
		$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


# (Make sure you keep your original toggle function down here!)
func attack_toggle(value: bool):
	attacking = value
	
	# Instantly kill the attack state and return the bones to normal movement
	if value == false:
		$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

func defend(forward: bool) -> void:
	var tween = create_tween()
	tween.tween_method(_defend_change,1.0 - float(forward), float(forward), 0.25)

func _defend_change(value: float) -> void:
	$AnimationTree.set("parameters/Sheildblend/blend_amount", value)
	

func switch_weapon(weapon_active: bool) -> void:
	if weapon_active:
		$Rig/Skeleton3D/RightHandSlotndSlot/sword_1handed2.show()
		$Rig/Skeleton3D/RightHandSlotndSlot/wand2.hide()
	else:
		$Rig/Skeleton3D/RightHandSlotndSlot/sword_1handed2.hide()
		$Rig/Skeleton3D/RightHandSlotndSlot/wand2.show()


func cast_spell() -> void:
	extra_animation.animation = 'Spellcast_Shoot'
	$AnimationTree.set("parameters/ExtraOneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)



func hit() -> void:
	extra_animation.animation = 'Hit_A'
	$AnimationTree.set("parameters/ExtraOneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$AnimationTree.set("parameters/AttackOneShot/request",  AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
	attacking = false

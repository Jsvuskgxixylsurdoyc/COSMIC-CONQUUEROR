extends Control
@onready var player = get_parent()
@onready var key_label = $CanvasLayer/keycounter
@onready var heart_container = $hearts/MarginContainer/HBoxContainer
@onready var spell_texture = $Spells/MarginContainer/TextureRect
@onready var energy_bar = $EnergyBar/MarginContainer/TextureProgressBar
@onready var pause_menu = $PauseMenu
@onready var stamina_bar =$StaminaBar/CenterContainer/MarginContainer/TextureProgressBar
var heart_scene: PackedScene = preload("res://scenes/entities/player/heart.tscn")
var fire_texture = preload("res://graphics/ui/fire.png")
var heal_texture = preload("res://graphics/ui/heal.png")
func setup(value: int) -> void:
	for i in value:
		var heart = heart_scene.instantiate()
		heart_container.add_child(heart)
		heart.change_alpha(1.0)
		await get_tree().create_timer(0.3).timeout


func update_health(value: int, direction: int) -> void:
	# remove all hearts
	for child in heart_container.get_children():
		child.queue_free()
	
	if direction < 0:
		for i in value:
			var heart = heart_scene.instantiate()
			heart_container.add_child(heart)
		var extra_heart = heart_scene.instantiate()
		heart_container.add_child(extra_heart)
		extra_heart.change_alpha(0.0)
	else:
		for i in value - 1:
			var heart = heart_scene.instantiate()
			heart_container.add_child(heart)
		var extra_heart = heart_scene.instantiate()
		heart_container.add_child(extra_heart)
		extra_heart.change_alpha(1.0)


func update_spell(spells, current_spell):
	if current_spell == spells.FIREBALL:
		spell_texture.texture = fire_texture
	if current_spell == spells.HEAL:
		spell_texture.texture = heal_texture


func update_energy(value: int) -> void:
	energy_bar.value = value

func update_stamina(current: int, target: int) -> void:
	var tween = create_tween()
	tween.tween_method(_change_stamina, current, target, 0.25)


func _change_stamina(value: int):
	stamina_bar.value = value

func change_stamina_alpha(value: float) -> void:
	var tween = create_tween()
	tween.tween_method(_change_alpha, 1.0 - value, value, 0.25)

func _change_alpha(value: float) -> void:
	stamina_bar.modulate.a = value
 
func _process(delta):
	key_label.text = "Keys: " + str(player.has_space_key)



func  _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		pause_menu.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		get_tree().paused = true
		pause_menu.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_resume_pressed():
	toggle_pause()



func _on_mainmenu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/envi/main_menu.tscn")





func _on_tryagain_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_return_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/envi/main_menu.tscn")

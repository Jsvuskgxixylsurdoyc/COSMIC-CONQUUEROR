extends Control

@export_file("*.tscn") var main_game_scene: String = "res://scenes/levels/level.tscn"
@onready var play_button = $VBoxContainer/play
@onready var quit_button = $VBoxContainer/quit

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Connect the buttons correctly
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

# Here is the missing function Godot was looking for!
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

# And the missing quit function!
func _on_quit_pressed():
	get_tree().quit()

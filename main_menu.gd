extends Control

# This variable holds the path to your actual game level!
@export_file("*.tscn") var main_game_scene: String = "res://scenes/entities/enemies/story.tscn"

# Grabbing the buttons using the exact spelling from the Scene Tree
@onready var play_button = $TextureRect/VBoxContainer/play
@onready var quit_button = $TextureRect/VBoxContainer/quit

func _ready():
	# Unlock the mouse so the player can actually click the menu buttons
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Connect the buttons via code
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	# Load the 3D level!
	get_tree().change_scene_to_file(main_game_scene)

func _on_quit_pressed():
	# Close the game entirely
	get_tree().quit()

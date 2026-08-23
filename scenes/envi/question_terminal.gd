extends Area3D

@export var blocking_wall: Node3D 
@export var correct_answer: String = "blackhole"
@onready var ui_screen = $CanvasLayer
@onready var input_box = $CanvasLayer/LineEdit
@onready var feedback_label = $CanvasLayer/Label2
# We removed @export. This is just an empty bucket that will catch the player automatically.
var caught_player = null 

func _ready():
	ui_screen.hide()
	feedback_label.hide()
func _on_body_entered(body):
	if body.name == "Player":
		caught_player = body # Catches the player perfectly
		ui_screen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
		caught_player.velocity = Vector3.ZERO
		await get_tree().physics_frame
		# Freezes the player so they stop stealing your mouse clicks!
		caught_player.is_in_menu = true
func _on_body_exited(body):
	if body.name == "Player":
		ui_screen.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
		
		# Unfreezes the player if they walk away
		if caught_player != null:
			caught_player.is_in_menu = false

func _on_button_pressed():
	if input_box.text.to_lower().strip_edges() == correct_answer.to_lower():
		#hide
		input_box.hide()
		$CanvasLayer/Button.hide()
		
		#show
		feedback_label.text = "Right Answer!, the gate has been opened"
		feedback_label.show()
		
		if blocking_wall != null:
			blocking_wall.queue_free()
		
		#player
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if caught_player != null:
			caught_player.is_in_menu = false
		
		#wait 2 sec
		await get_tree().create_timer(2.0).timeout
		queue_free()
	else:
		feedback_label.text = "wrong answer!"
		feedback_label.show()
		input_box.text = ""
		
		await get_tree().create_timer(2.0).timeout
		feedback_label.hide

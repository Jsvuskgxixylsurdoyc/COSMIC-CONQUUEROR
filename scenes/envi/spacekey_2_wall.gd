extends StaticBody3D


@export var correct_answer: String = "universe"

@onready var ui_screen = $CanvasLayer
@onready var input_box = $CanvasLayer/LineEdit
@onready var feedback_label = $CanvasLayer/Label2
@onready var submit_button = $CanvasLayer/Button

var caught_player = null

func _ready() -> void:
	ui_screen.hide()
	feedback_label.hide()

func _on_trigger_zone_body_entered(body):
	if body.name == "Player":
		caught_player = body
		ui_screen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		caught_player.is_in_menu = true

func _on_trigger_zone_body_exited(body):
	if body.name == "Player":
		ui_screen.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if caught_player != null:
			caught_player.is_in_menu = false
			caught_player = null

func _on_button_pressed():
	if input_box.text.to_lower().strip_edges() == correct_answer.to_lower():
		input_box.hide()
		submit_button.hide()
		feedback_label.text = "Right answer"
		feedback_label.show()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if caught_player != null:
			caught_player.is_in_menu = false
		# wait
		await get_tree().create_timer(2.0).timeout
		queue_free()
	else:
		feedback_label.text = "Wrong Answer!"
		feedback_label.show()
		input_box.text = ""
		await get_tree().create_timer(2.0).timeout
		feedback_label.hide()

extends Area3D



func _on_body_entered(body: Node3D) -> void:
		if body.name == "Player":
			if body.has_space_key >= 3:
				#1
				body.get_node("UI/victoryscreen").show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
				get_tree().paused = true
		else:
			print("access denied")

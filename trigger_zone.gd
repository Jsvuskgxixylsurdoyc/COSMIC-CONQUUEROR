extends Area3D



# This signal triggers the moment something walks into the invisible Area3D
func _on_body_entered(body):
	
	# 1. Make sure it is actually the Player touching it, not a skeleton or bullet!
	if body.name == "Player":
		
		# 2. Check if the player has found all 3 keys
		if body.has_space_key >= 3:
			
			# --- SUCCESS SEQUENCE ---
			# Show the Victory Menu (Make sure the path matches your tree!)
			body.get_node("UI/victoryscreen").show()
			
			# Unlock the mouse so they can click "Exit" or "Explore"
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
			# Freeze the game
			get_tree().paused = true
			
		else:
			
			# --- FAIL SEQUENCE (Not Enough Keys) ---
			# Grab the warning label from the player's UI
			var warning_label = body.get_node("UI/KeyWarningLabel")
			
			# Show the warning message
			warning_label.show()
			
			# Wait for exactly 3 seconds
			await get_tree().create_timer(3.0).timeout
			
			# Hide the warning message so it doesn't stay on screen forever
			warning_label.hide()

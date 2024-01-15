extends Control





func _on_button_start_button_up() -> void:
	#for scene in get_tree().root.get_children():
		#scene.queue_free()
	get_tree().change_scene_to_file("res://Game/Scenes/GameScene.tscn")


func _on_button_quit_button_up() -> void:
	get_tree().quit()

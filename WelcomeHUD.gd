extends CanvasLayer


var pcscene =load("res://main.tscn")

func _on_button_pressed():
	print('was pressed')
	get_tree().change_scene_to_packed(pcscene)

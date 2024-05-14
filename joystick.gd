extends Node2D

signal joystick_pressed
signal joystick_released


var posVector: Vector3 #Vector that knob produces and translated to player




func _on_button_button_down():
	joystick_pressed.emit()


func _on_button_button_up():
	joystick_released.emit()

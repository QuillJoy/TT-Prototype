extends CharacterBody3D
@onready var joystick = $"../CanvasLayer/Joystick"
@export var rotate_speed: float = 1.0

@export var can_rotate: bool

var joystick_pressed: bool

var touch_points: Dictionary = {}
var speed = 5

func _physics_process(delta):
	var direction = joystick.posVector
	direction.z = direction.y
	direction.y = 0
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector3(0,0,0)
		
	move_and_slide()


func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	elif event is InputEventScreenDrag:
		handle_drag(event)

		
func handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
		
func handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	if !joystick_pressed:
		if touch_points.size() == 1:
			if can_rotate:
				rotate_object_local(Vector3.UP, event.relative.x * 0.001)
				print(self.rotation_degrees)
	

func _on_joystick_joystick_pressed():
	joystick_pressed = true


func _on_joystick_joystick_released():
	joystick_pressed = false



extends CharacterBody3D
@onready var joystick = $"../CanvasLayer/Joystick"
@export var rotate_speed: float = 1.0
@onready var first_person_camera_pivot = $FirstPersonCameraPivot

@onready var first_person_camera = $FirstPersonCameraPivot/FirstPersonCamera

@export var can_rotate: bool

var joystick_pressed: bool
@onready var camera_3d = $CameraPivot/Camera3D
@onready var camera_pivot = $CameraPivot

var touch_points: Dictionary = {}
var speed = 5

func _physics_process(delta):
	var direction = joystick.posVector
	direction.z = direction.y
	direction.y = 0
	
	if(first_person_camera.current):
		var camera_rotation_y = first_person_camera.global_transform.basis.get_euler().y

		direction = direction.rotated(Vector3.UP,camera_rotation_y).normalized()	
	else:
	
		var camera_rotation_y = camera_3d.global_transform.basis.get_euler().y

		direction = direction.rotated(Vector3.UP,camera_rotation_y).normalized()

	if direction:
		velocity = direction * speed
		if(first_person_camera.current):
			pass
		else:
			$Pivot.look_at($Pivot.global_transform.origin + direction, Vector3.UP)
	else:
		velocity = Vector3(0,0,0)
		
	move_and_slide()


func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	# only when camera is first person
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
				if(first_person_camera.current):
					first_person_camera_pivot.rotate_object_local(Vector3.UP, event.relative.x * -0.001) 
					first_person_camera.rotate_object_local(Vector3.RIGHT, event.relative.y * -0.001)
					$Pivot.look_at(first_person_camera.global_transform.origin + -first_person_camera.global_transform.basis.z, Vector3.UP)

				else:
					
					camera_pivot.rotate_object_local(Vector3.UP, event.relative.x * -0.001) 
					camera_3d.rotate_object_local(Vector3.RIGHT, event.relative.y * -0.001)

func _on_joystick_joystick_pressed():
	joystick_pressed = true


func _on_joystick_joystick_released():
	joystick_pressed = false




func _on_button_pressed():

	var zoom_factor = .9
	print(camera_3d.size)
	var new_size = camera_3d.size * zoom_factor

	camera_3d.size = new_size
	
	if(camera_3d.size < 10.0):
		first_person_camera.current = true


func _on_zoom_out_pressed():
	var zoom_factor = 1.1
	print(camera_3d.size)
	var new_size = camera_3d.size * zoom_factor

	camera_3d.size = new_size
	
	if(camera_3d.size > 10.0):
		camera_3d.current = true
	


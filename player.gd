extends CharacterBody3D
@onready var joystick = $"../CanvasLayer/Joystick"

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

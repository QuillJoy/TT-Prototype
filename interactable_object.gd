extends StaticBody3D


@onready var directional_light_3d = $"../DirectionalLight3D"

func _input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventScreenTouch):
		if(event.is_pressed()):
			print("box was pressed")
			directional_light_3d.visible = !directional_light_3d.visible

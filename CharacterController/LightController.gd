extends Node2D

var light_scenes = []

func new_light_viewport(var new_view: Viewport) -> void:
	light_scenes.push_back(new_view)
	

func _draw():
	var offset: Vector2 = get_viewport_rect().size*-0.5
	for scene in light_scenes:
		draw_texture(scene.get_texture(), offset);

extends Viewport

export var LightController: NodePath = ""

func _ready():
	get_node(LightController).new_light_viewport(self)
	var offset: Vector2 = get_size()*0.5
	canvas_transform.origin = offset;

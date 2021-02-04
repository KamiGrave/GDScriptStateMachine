extends Polygon2D

var _instance = null

func _ready():
	var model: ExampleStateMachineModel = ExampleStateMachineModel.new()
	_instance = model.create_instance(self)
	$Timer.start(2)
	
func _on_Timer_timeout():
	print("Timer expired")
	_instance.add_action(StateAction.new("TimerExpired"))

func _input(event):
	if event.is_action_released("ui_up"):
		_instance.add_action(StateAction.new("UpPressed"))
		
func _physics_process(delta):
	_instance.update_state_machine()

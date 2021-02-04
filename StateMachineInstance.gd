class_name StateMachineInstance
	
var _target_obj = null

var _current_state: String = ""

var _state_model

var _action_list = []

func _init(target_obj, model):
	_state_model = model
	_current_state = model._entry_state
	_target_obj = target_obj

func add_action(action: StateAction):
	# Push a new action onto the action list for processing
	_action_list.push_back(action)

func update_state_machine():
	# Process all the actions in the list and record our new state
	_current_state = _state_model._update(_current_state, _target_obj, _action_list)

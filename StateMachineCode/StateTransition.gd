class_name StateTransition

var from_state: String
var action_name: String
var to_state: String
var action: FuncRef
var guard: FuncRef

func _init(in_from_state: String, in_action_name: String, in_to_state: String, in_action: FuncRef, in_guard: FuncRef):
	from_state = in_from_state
	action_name = in_action_name
	to_state = in_to_state
	action = in_action
	guard = in_guard

class_name StateMachineModel

var _entry_state: String

var _transition_lookup: Dictionary

func _init(entry_state: String):
  _entry_state = entry_state

func add_state_transition(from_state: String, action_name: String, to_state: String, action: FuncRef = null, guard: FuncRef = null) -> void:
  var newTran: StateTransition = StateTransition.new(from_state, action_name, to_state, action, guard)
  # If this is a new state, create a new array in the lookup
  if not _transition_lookup.has(from_state):
    _transition_lookup[from_state] = []
  _transition_lookup[from_state].append(newTran)

func create_instance(target_obj) -> StateMachineInstance:
  # Create a state machine instance that will use this model
  return StateMachineInstance.new(target_obj, self)

func _update(current_state: String, target_obj, action_list: Array) -> String:
  if not _transition_lookup.has(current_state):
    # Deadend state just return
    return current_state
  
  # action_name of "" is considered the 'instant' event, so will transition automatically
  var action_name: String = ""
  var action = null

  # Loop until break
  while(true):
    # For each transition for the current state
    for tran in _transition_lookup[current_state]:
      # If the action name matches the action for the transition
      # and we don't have a guard or the guard passes
      if tran.action_name == action_name && (tran.guard == null || tran.guard.call_func(target_obj, action)):
        # If there's an action function, call it, if action isn't null, pop it from the list
        # The action function will return true to consume the event, or false to leave it for the next state
        if (tran.action != null && tran.action.call_func(target_obj, action)) && action != null:
          action_list.pop_front()
        # Call recursively for the new state we've transitioned to
        return _update(tran.to_state, target_obj, action_list)
    
    # If action isn't null, we should remove it from the front of the list
    if action != null:
      action_list.pop_front()

    # If there's still actions to process, get the next one
    if action_list.size() > 0:
      print("Getting next action")
      action = action_list[0]
      action_name = action.action_name   
      print("Next action: " + action_name)
    else:
    # Else, leave the while loop
      break
  
  # Return current state, as we've not moved anywhere
  return current_state

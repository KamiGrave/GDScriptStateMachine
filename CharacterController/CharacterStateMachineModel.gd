extends StateMachineModel

class_name CharacterStateMachineModel

const DIRECTION_CHANGED_ACTION = "DirChanged"
const JUMP_PRESSED_ACTION = "Jump"
const WALL_HIT_ACTION = "WallHit"
const LANDED_ACTION = "Landed"
const FALL_ACTION = "Fall"
const TICK_ACTION = "Tick"

func _init().("Idle"):
	add_state_transition("Idle", DIRECTION_CHANGED_ACTION, "Walk", funcref(self, "start_walking"), funcref(self, "moving_guard"))
	add_state_transition("Idle", JUMP_PRESSED_ACTION, "Jump", funcref(self, "jump"))
	add_state_transition("Idle", FALL_ACTION, "Jump", funcref(self, "jump"))
	
	add_state_transition("Idle", TICK_ACTION, "Idle", funcref(self, "ground_tick"))
	
	add_state_transition("Walk", DIRECTION_CHANGED_ACTION, "Idle", funcref(self, "stop_walking"), funcref(self, "not_moving_guard"))
	add_state_transition("Walk", DIRECTION_CHANGED_ACTION, "Walk", funcref(self, "start_walking"), funcref(self, "moving_guard"))
	add_state_transition("Walk", JUMP_PRESSED_ACTION, "Jump", funcref(self, "jump"))
	
	add_state_transition("Walk", TICK_ACTION, "Walk", funcref(self, "ground_tick"))
	
	add_state_transition("Jump", DIRECTION_CHANGED_ACTION, "Jump", funcref(self, "change_jump_dir"))
	add_state_transition("Jump", LANDED_ACTION, "Walk", funcref(self, "land"))
	
	add_state_transition("Jump", TICK_ACTION, "Jump", funcref(self, "air_tick"))

func ground_tick(obj, action):
	print("Tick")
	var delta: float = action.params["delta"]
	obj.velocity -= obj.velocity * obj.DAMPING * delta
	obj.velocity.y += obj.GRAVITY * delta
	obj.velocity.x += obj.movement * obj.ACCELERATION * delta
	
	obj.velocity = obj.move_and_slide(obj.velocity, Vector2.UP);
	
	if !obj.is_on_floor():
		obj.fsm.add_action(StateAction.new(FALL_ACTION))
	
	return true
	
func air_tick(obj, action):
	var delta: float = action.params["delta"]
	obj.velocity -= obj.velocity * obj.DAMPING * delta
	obj.velocity.y += obj.GRAVITY * delta
	obj.velocity.x += obj.movement * obj.ACCELERATION * delta
	
	obj.velocity = obj.move_and_slide(obj.velocity, Vector2.UP);
	
	if obj.is_on_floor():
		obj.fsm.add_action(StateAction.new(LANDED_ACTION))
		
	return true

func moving_guard(obj, action):
	return abs(action.params["dir"]) > 0.1
	
func not_moving_guard(obj, action):
	return !moving_guard(obj, action)

func start_walking(obj, action):
	obj.get_node("AnimationPlayer").play("Walk")
	var direction = action.params["dir"]
	obj.get_node("Sprite").scale.x = abs(obj.get_node("Sprite").scale.x) * direction
	obj.movement = direction

	return true;
	
func change_jump_dir(obj, action):
	var direction = action.params["dir"]
	if direction != 0:
		obj.get_node("Sprite").scale.x = abs(obj.get_node("Sprite").scale.x) * direction
	obj.movement = direction
	return true;
	
func stop_walking(obj, action):
	obj.get_node("AnimationPlayer").play("Idle")
	obj.movement = 0
	return true;
	
func jump(obj, action):
	obj.get_node("AnimationPlayer").play("Jump")
	obj.velocity.y -= 2400;
	return true;
	
func land(obj, action):
	# Add a new action so we trasition to either idle 
	# or walking based on if we're moving or not
	var move_action = StateAction.new(DIRECTION_CHANGED_ACTION)
	move_action.params["dir"] = obj.movement
	obj.fsm.add_action(move_action)
	return true;

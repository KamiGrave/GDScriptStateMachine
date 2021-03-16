extends KinematicBody2D

const ACCELERATION = 5000
const MAX_SPEED = 500 # acceleration == damping*max_speed
const DAMPING: Vector2 = Vector2(ACCELERATION / MAX_SPEED, 2)

const GRAVITY = 7000

onready var velocity: Vector2 = Vector2(0,0)
onready var movement: = 0

var fsm: StateMachineInstance = null

func _ready():
	var charStateMachineModel = CharacterStateMachineModel.new()
	fsm = charStateMachineModel.create_instance(self)
	add_child(fsm)
	
func _input(event):
	if event.is_action("ui_left"):
		var action: StateAction = StateAction.new(CharacterStateMachineModel.DIRECTION_CHANGED_ACTION)
		if(event.is_pressed()):
			action.params["dir"] = -1
		else:
			action.params["dir"] = 0
		fsm.add_action(action)
	elif event.is_action("ui_right"):
		var action: StateAction = StateAction.new(CharacterStateMachineModel.DIRECTION_CHANGED_ACTION)
		if(event.is_pressed()):
			action.params["dir"] = 1
		else:
			action.params["dir"] = 0
		fsm.add_action(action)
	elif event.is_action_pressed("ui_up"):
		var action: StateAction = StateAction.new(CharacterStateMachineModel.JUMP_PRESSED_ACTION)
		fsm.add_action(action)

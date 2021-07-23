extends StateMachineModel

class_name ExampleStateMachineModel

func _init().("Red"):
  # When timer expires go from Red to Amber and call GoAmberAction
  add_state_transition("Red", "TimerExpired", "Amber", funcref(self, "GoAmberAction"))
  # When timer expires go from Amber to Green and call GoGreenAction
  add_state_transition("Amber", "TimerExpired", "Green", funcref(self, "GoGreenAction"))
  # When up is pressed go from Green to AmberToRed and call GoAmberAction
  add_state_transition("Green", "UpPressed", "AmberToRed", funcref(self, "GoAmberAction"))
  # When timer expires go from AmberToRed to Red and call GoRedAction
  add_state_transition("AmberToRed", "TimerExpired", "Red", funcref(self, "GoRedAction"))
    
func GoAmberAction(target_obj, _action) -> bool:
  print("Amber called")
  # Change the colour of the poly
  target_obj.color = Color("ff8300")
  # Start the timer for next transition
  target_obj.get_node("Timer").start(3);
  return true
  
func GoGreenAction(target_obj, _action) -> bool:
  target_obj.color = Color("038815")
  return true
  
func GoRedAction(target_obj, _action) -> bool:
  target_obj.color = Color("880303")
  target_obj.get_node("Timer").start(3);
  return true

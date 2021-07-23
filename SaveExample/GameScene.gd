extends Control

func _ready():
  # Load the pressed button
  var pressed_index = SaveDataAutoload.get_button()-1
  var index: int = 0;
  # For each button in the grid container
  for child in $GridContainer.get_children():
    if child is Button:
      var button: Button = child
      # Connect the pressed event
      button.connect("button_up", self, "on_button_pressed", [index])
      # If this is the saved index, set the button to pressed
      if pressed_index == index:
        button.pressed = true
      else:
        button.pressed = false
      index = index+1
  # Connect quit button
  $Button.connect("button_up", self, "on_quit")
  
func on_quit():
  # On quit, load the load scene again
  get_tree().change_scene("res://SaveExample/LoadScene.tscn")
      
func on_button_pressed(button_id: int):
  # When a button is pressed, turn others off
  var index: int = 0;
  for child in $GridContainer.get_children():
    if child is Button:
      var button: Button = child
      if index == button_id:
        button.pressed = true
      else:
        button.pressed = false
      index += 1

  # Set new selected button
  SaveDataAutoload.set_button(button_id+1)
  

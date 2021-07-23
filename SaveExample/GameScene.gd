extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  var pressed_index = SaveDataAutoload.get_button()-1
  var index: int = 0;
  for child in $GridContainer.get_children():
    if child is Button:
      var button: Button = child
      button.connect("button_up", self, "on_button_pressed", [index])
      if pressed_index == index:
        button.pressed = true
      else:
        button.pressed = false
      index = index+1
      
  $Button.connect("button_up", self, "on_quit")
  
func on_quit():
  get_tree().change_scene("res://SaveExample/LoadScene.tscn")
      
func on_button_pressed(button_id: int):
  var index: int = 0;
  for child in $GridContainer.get_children():
    if child is Button:
      var button: Button = child
      if index == button_id:
        button.pressed = true
      else:
        button.pressed = false
      index += 1

  SaveDataAutoload.set_button(button_id+1)
  

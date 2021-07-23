extends Node

class_name SaveDataHandler

const save_files := ["res://SaveExample/sav0.tres", "res://SaveExample/sav1.tres"]
const num_slots := 2

var save_data: SaveData

func open_slot(slot_id):
  save_data = get_game_data(slot_id)
  save_data.name = "Slot " + str(slot_id+1)
  save_data.save()
    
func get_game_data(slot_id: int, create: bool = false) -> SaveData:
  var dir = Directory.new()
  var save_path = save_files[slot_id]
  if dir.file_exists(save_path):
    var old_save = load(save_path)
    if old_save is SaveData:
      return old_save
    else:
      return null
  elif create:
          var new_save = SaveData.new()
          if new_save.save_as(save_path) == OK:
            return new_save
  
  return null
  
func set_button(button_id: int):
  save_data.button_pressed = button_id
  save_data.save()
  
func get_button() -> int:
  return save_data.button_pressed
  
func delete_slot(slot_id: int):
  var dir = Directory.new()
  var save_path = save_files[slot_id]
  dir.remove(save_path)

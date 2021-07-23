extends Panel

func _ready():
  for i in range(0, SaveDataAutoload.num_slots):
    var slot_ui : Button = load("res://SaveExample/SlotUI.tscn").instance()
    var save_data: SaveData = SaveDataAutoload.get_game_data(i, true)
    slot_ui.get_node("Name").text = save_data.name
    slot_ui.get_node("Number").text = str(save_data.button_pressed)
    $VBoxContainer.add_child(slot_ui)
    slot_ui.get_node("Delete").connect("button_up", self, "on_delete", [i, slot_ui])
    slot_ui.connect("button_up", self, "slot_pressed", [i])
    
func on_delete(slot_id: int, slot_ui: Button):
  SaveDataAutoload.delete_slot(slot_id)
  var save_data: SaveData = SaveDataAutoload.get_game_data(slot_id, true)
  slot_ui.get_node("Name").text = save_data.name
  slot_ui.get_node("Number").text = str(save_data.button_pressed)
    
func slot_pressed(slot_id: int):
  SaveDataAutoload.open_slot(slot_id)
  get_tree().change_scene("res://SaveExample/GameScene.tscn")

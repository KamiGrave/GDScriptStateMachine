extends Resource

class_name SaveData

export var name: String = "Empty"
export var button_pressed: int = 0

func save_as(file_path: String) -> int:
  return ResourceSaver.save(file_path, self, ResourceSaver.FLAG_CHANGE_PATH);

func save() -> int:
  return ResourceSaver.save(resource_path, self)

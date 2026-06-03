extends Node

var save_location = "user://SaveFile.json"

var content_to_save = {
	'level':'',
	'gold': 0,
	'livingwood':0,
	'ash':0,
	'ice':0,
	'windsteel':0,
	'staff_levels': [0,0,0,0],
	'armor_levels':[0,0,0,0]
}

func _save():
	var File = FileAccess.open(save_location,FileAccess.WRITE)
	File.store_var(content_to_save.duplicate())
	File.close()
	
func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location,FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		return save_data
		

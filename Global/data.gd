
class_name Data
extends Resource

# mode, title, BPM, time, streams, notes
@export var scroll_time : float = 0.5
@export var beat_maps : Array = []
#@export var MapContainer := MapContainer.new()

var save_path = 'user://save'

func _init():
	resource_path = save_path
	print("Data initialize")

func save_game() -> void:
	beat_maps = MapContainer.beat_maps
	ResourceSaver.save(self, save_path)
	print('Save successful!')
	
func load_game():
	#if ResourceLoader.has_cached(save_path):
	print('Load successful!')
	print(ResourceLoader.load(save_path))
	return ResourceLoader.load(save_path)
	

func print_beat_maps_info() -> void:
	if ! MapContainer.beat_maps:
		print('There are not map')
		return
	for i in MapContainer.beat_maps:
		print('------------------------')
		print("titie: " + str(i.title))
		print("mode: " + str(i.mode))
		print("BPM: " + str(i.bpm))
		print("streams: " + str(i.streams))
		print("time: " + str(i.time))
		print("notes: " + str(i.notes))
	print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')


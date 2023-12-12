
class_name Data
extends Resource

# mode, title, BPM, time, repeat_times, notes
@export var scroll_time : float = 0.5
@export var audio_offset : int =  0
@export var hit_offset : int = 0
@export var beat_maps : Array = []

var save_path = 'user://save'

func _init():
	resource_path = save_path
	print("Data initialize")

func save_game() -> void:
	beat_maps = MapContainer.beat_maps
	scroll_time = Global.scroll_time
	audio_offset = Global.audio_offset
	hit_offset = Global.hit_offset
	
	ResourceSaver.save(self, save_path)
	print('Save successful!')
	
func load_game():
	#if ResourceLoader.has_cached(save_path):
	print('Load successful!')
	print(ResourceLoader.load(save_path))
	return ResourceLoader.load(save_path)
	

func print_beat_maps_info() -> void:
	if ! MapContainer.beat_maps:
		print('There is no map')
		return
	
	for i:BeatMap in MapContainer.beat_maps:
		i.print_beat_map_info()

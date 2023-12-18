
class_name Data
extends Resource

# mode, title, BPM, time, repeat_times, notes
@export var scroll_time : float = 0.5
@export var audio_offset : int =  0
@export var hit_offset : int = 0
@export var bpm_offset : float = 0.0
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
	bpm_offset = Global.bpm_offset
	
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

func load_default_data() -> void:
	var default_map = BeatMap.new( '4k', 'easy', 120.0, 0, 5, [[HitObject.new(1), HitObject.new(2)],[HitObject.new(1)],[HitObject.new(1.5)],[HitObject.new(2), HitObject.new(1)]] )
	MapContainer.add_beat_map(default_map)
	
	
	var hard_map = BeatMap.new( '4k', 'hard', 180.0, 0.0, 2, [[HitObject.new(1), HitObject.new(3), HitObject.new(2)],[HitObject.new(1), HitObject.new(3)],[HitObject.new(2)],[HitObject.new(1), HitObject.new(2)]] )
	MapContainer.add_beat_map(hard_map)
	# 1 1 0 0 
	# 1 0 1 1 
	# 1 1 0 1 
	
	# 1 1 0 0 
	# 1 0 1 1 
	# 1 1 0 1 
	var crazy_notes : Array[Array] = [
		[3.0/4,1+4.0/4],
		[4.0/4,1+3.0/4],
		[2.0/4,1+1.0/4],
		[1.0/4,1+2.0/4],
	]
	var crazy_map = BeatMap.new( '4k', 'crazy', 180.0, 0.0, 40, notes_generator(crazy_notes))
	MapContainer.add_beat_map(crazy_map)
	
	print('Data: ', MapContainer.beat_maps)

func notes_generator(beat_time: Array[Array]) -> Array[Array]:
	var notes : Array[Array] = []
	for track in beat_time:
		notes.append(track.map(func (time): return HitObject.new(time)))
		
	return notes

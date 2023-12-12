class_name BeatMap


# parameters
var mode : String = ''
var title : String = ''
var bpm : float = 0.0
var time : float = 0.0
var repeat_times : int = 0
var notes : Array[Array] = [[]]

var id : float 
var play_data : Array[PlayResult]

# mode, title, BPM, time, repeat_times, notes
func _init(p_mode: String , p_title: String, p_bpm: float, p_time: float, p_streams: int, p_notes : Array[Array]):
	mode = p_mode
	title = p_title
	bpm = p_bpm
	time = p_time
	repeat_times = p_streams
	notes = p_notes
	
	sort_notes()
	time = set_beat_map_time()
	id = Global.get_current_time()

func _ready():
	pass 

func set_beat_map_time() -> float:
	return max(time, repeat_times * get_bpm_interval() * get_least_stream())
	
func get_least_stream() -> int:
	return ceil(get_notes_time().max())

func get_bpm_interval() -> float:
	return 60 / bpm
	
func get_notes_count():
	var sum = 0 
	for track in notes:
		sum += len(track)
	return sum
	
	
func get_notes_time() -> Array:
	var notes_time = []
	for track in notes:
		notes_time.append_array(track)
	
	notes_time =  notes_time.map(func (note:HitObject): return note.time )
	return notes_time
	
func sort_notes() -> void:
	for track in notes:
		track as Array[HitObject]
		track.sort_custom(func (a,b): return a.time < b.time)
	
	
func print_beat_map_info() -> void:
	print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
	print("Titie: " + str(title))
	print("Mode: " + str(mode))
	print("BPM: " + str(bpm))
	print("Repeat_times: " + str(repeat_times))
	print("Time: " + str(time))
	print("ID: " + str(id))
	print("Notes count: " + str(get_notes_count()))
	for track in notes:
		print('  Track')
		for note:HitObject in track:
			print('    time: %f' % [note.time])
			#print('  type: ' + str(note.type))
			#print('  random: ' + str(note.is_random))

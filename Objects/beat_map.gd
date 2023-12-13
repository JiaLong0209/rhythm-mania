class_name BeatMap


# parameters
var mode : String = ''
var title : String = ''
var bpm : float = 0.0
var time : float = 0.0
var repeat_times : int = 0
var notes : Array[Array] = [[]]

var original_notes: Array[Array] = [[]]
var id : float 
var play_data : Array[PlayResult]


# mode, title, BPM, time, repeat_times, notes
func _init(p_mode: String , p_title: String, p_bpm: float, p_time: float, p_streams: int, p_notes : Array[Array]):
	mode = p_mode
	title = p_title
	bpm = p_bpm
	time = p_time
	repeat_times = p_streams
	notes = p_notes.duplicate(true)
	var temp = p_notes.duplicate(true)
	original_notes = temp.duplicate(true)
	
	sort_notes()
	time = set_beat_map_time()
	id = Global.get_current_time()

func _ready():
	pass 

func set_beat_map_time() -> float:
	return max(time, repeat_times * get_bpm_interval() * get_max_stream())
	
func get_max_stream() -> int:
	print(get_notes_time(original_notes))
	return ceil(get_notes_time(original_notes).max())

func get_bpm_interval() -> float:
	return 60 / bpm
	
func get_notes_count() -> int:
	var sum = 0 
	for track in notes:
		sum += len(track)
	return sum
	
func get_repeat_notes() -> Array[Array]:
	var max_stream = get_max_stream()
	var repeat_notes = notes
	for i in range(repeat_notes.size()):
		var track = repeat_notes[i] as Array[HitObject]
		var temp = track.duplicate(true)
		print('least stream:' , max_stream)
		for times in range(repeat_times - 1):
			track.append_array(temp.map(func (x): return HitObject.new(float(x.time) + float(max_stream * times+1))))
		repeat_notes[i] = track
	return repeat_notes
	
func get_notes_time(p_notes: Array[Array]) -> Array:
	var notes_time = []
	for track in p_notes:
		notes_time.append_array(track.map(func (note:HitObject): return note.time))
	
	return notes_time

func stream_to_sec():
	var temp_notes = notes.duplicate(true)
	var interval = get_bpm_interval()
	
	for i in range(notes.size()):
		for j in range(notes[i].size()):
			temp_notes[i][j].time *= interval
	
	return temp_notes
	
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

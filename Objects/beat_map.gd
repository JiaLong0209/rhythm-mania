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
	notes = p_notes.duplicate(true)
	
	sort_notes()
	set_beat_map_time()
	
	id = Global.get_current_time()

func set_beat_map_time() -> void:
	time = max(time, get_bpm_interval() * get_max_stream())
	print('\tMap time: %f' % time)
	
func get_max_stream() -> int:
	print(get_notes_beat_time())
	return ceil(get_notes_beat_time().max())

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
		for times in range(repeat_times):
			if(times == 0): continue
			track.append_array(temp.map(func (x): return HitObject.new(float(x.beat_time) + float(max_stream * times))))
		repeat_notes[i] = track
	return repeat_notes
	
func get_notes_beat_time() -> Array:
	var notes_time = []
	for track in notes:
		notes_time.append_array(track.map(func (note:HitObject): return note.beat_time))
	return notes_time

func stream_to_sec() -> void:
	var interval = get_bpm_interval()
	for track in notes:
		for note in track:
			(note as HitObject).set_sec_time(interval)
	
func sort_notes() -> void:
	for track in notes:
		track as Array[HitObject]
		track.sort_custom(func (a,b): return a.beat_time < b.beat_time)
	
	
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
			print('    time: %f' % [note.beat_time])
			#print('  type: ' + str(note.type))
			#print('  random: ' + str(note.is_random))

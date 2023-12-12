extends Node2D

var beat_map: BeatMap 
var time_start : float = 0
var time_now : float = 0
var time_elapsed : float = 0
var time_offset = 0

var play_result : PlayResult
var spawn_notes: Array[Array]

var is_game_start = true


@onready var note_container = $AspectRatioContainer/CenterContainer/NoteContainer
@onready var note_tracks = note_container.get_node('TrackContainer').get_children() as Array[NoteTrack]

func _ready():
	print('Game: Start!')
	load_map(MapContainer.beat_maps[1])
	start()

func _process(delta):
	if(is_game_start):
		time_now = Global.get_current_time()
		time_elapsed = time_now - time_start
		
		for i in range(spawn_notes.size()):
			var track = spawn_notes[i]
			if(!track): continue
			
			if track[0].time + time_offset < time_elapsed :
				note_tracks[i].create_note()
				spawn_notes[i].pop_front()
				

func start() -> void:
	SoundPlayer.play_sound_by_time(beat_map.time)
	time_start = Global.get_current_time()

func load_map(p_beat_map: BeatMap) -> void:
	beat_map = p_beat_map
	print('--------')
	SoundPlayer.bpm = beat_map.bpm
	beat_map.notes = beat_time_convert_to_real_time(beat_map.notes)
	beat_map.notes = get_repeat_notes(beat_map)
	
	spawn_notes = beat_map.notes.duplicate(true)
	
	beat_map.print_beat_map_info()
	for i in range(note_tracks.size()):
		if beat_map.notes.size()-1 < i: break
		var note_track : NoteTrack = note_tracks[i]
		#note_track.notes = beat_map.notes[i]
		note_track.set_notes(beat_map.notes[i])


func beat_time_convert_to_real_time(map_notes: Array[Array]):
	var interval = beat_map.get_bpm_interval()
	var new = map_notes
	for i in range(new.size()):
		new[i] = new[i].map(func (x): 
			x.time = x.time * interval
			return x
		)
	return new

func get_repeat_notes(beat_map: BeatMap) -> Array[Array]:
	var repeat_times = beat_map.repeat_times as int
	var notes = beat_map.notes
	var least_stream = beat_map.get_least_stream()
	for i in range(notes.size()):
		var track = notes[i] as Array[HitObject]
		var temp = track.duplicate(true)
		print('least ' , least_stream)
		for times in range(repeat_times):
			track.append_array(temp.map(func (x): return HitObject.new(float(x.time) + float(least_stream * times+1))))
		notes[i] = track
	
	return notes

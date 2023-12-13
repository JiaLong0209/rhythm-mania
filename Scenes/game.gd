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
	#load_map(MapContainer.beat_maps[0])
	start()

func _process(delta):
	if(is_game_start):
		time_now = Global.get_current_time()
		time_elapsed = time_now - time_start
		
		for i in range(spawn_notes.size()):
			var track = spawn_notes[i]
			if(!track): continue
			
			#if track[0].time + time_offset < time_elapsed :
				#note_tracks[i].create_note()
				#spawn_notes[i].pop_front()
				

func start() -> void:
	create_all_notes()
	time_start = Global.get_current_time()
	await get_tree().create_timer(Global.scroll_time).timeout
	print(beat_map.get_max_stream(), ' ', beat_map.repeat_times)
	SoundPlayer.play_sound_by_beats(beat_map.get_max_stream() * beat_map.repeat_times)
	#SoundPlayer.play_sound_by_time(beat_map.time)

func load_map(p_beat_map: BeatMap) -> void:
	beat_map = p_beat_map
	print('--------')
	SoundPlayer.bpm = beat_map.bpm
	print(SoundPlayer.bpm)
	beat_map.stream_to_sec()
	#beat_map.notes = stream_to_sec(beat_map.notes)
	#print('tTTTTTmes: ', beat_map.get_notes_time(beat_map.original_notes))
	#print('tTTTTTmes: ', beat_map.get_notes_time(beat_map.notes))
	beat_map.notes = beat_map.get_repeat_notes()
	
	spawn_notes = beat_map.notes.duplicate(true)
	
	beat_map.print_beat_map_info()
	for i in range(note_tracks.size()):
		if beat_map.notes.size()-1 < i: break
		var note_track : NoteTrack = note_tracks[i]
		#note_track.notes = beat_map.notes[i]
		note_track.set_notes(beat_map.notes[i])


func stream_to_sec(map_notes: Array[Array]):
	var interval = beat_map.get_bpm_interval()
	var new = map_notes.duplicate(true)
	for i in range(new.size()):
		new[i] = new[i].map(func (x): 
			x.time = x.time * interval
			return x
		)
	return new

#func get_repeat_notes(beat_map: BeatMap) -> Array[Array]:
	#var repeat_times = beat_map.repeat_times as int
	#var notes = beat_map.notes
	#var max_stream = beat_map.get_max_stream()
	#for i in range(notes.size()):
		#var track = notes[i] as Array[HitObject]
		#var temp = track.duplicate(true)
		#print('least ' , max_stream)
		#for times in range(repeat_times):
			#track.append_array(temp.map(func (x): return HitObject.new(float(x.time) + float(max_stream * times+1))))
		#notes[i] = track
	#return notes

func create_all_notes() -> void:
	for i in range(spawn_notes.size()):
		var track = spawn_notes[i]
		if(!track): continue
		
		while(spawn_notes[i]):
			var time = spawn_notes[i].pop_front().time
			(note_tracks[i] as NoteTrack).create_note_by_sec(time)
			
			

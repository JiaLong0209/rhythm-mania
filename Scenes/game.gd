class_name Game
extends Node2D

var beat_map: BeatMap 
var time_start : float = 0
var time_now : float = 0
var time_elapsed : float = 0
var time_offset = -0.01

var bpm_offset : float = Global.bpm_offset

var play_result : PlayResult
var spawn_notes: Array[Array]

var is_game_start = true
var current_map_index = 2

@onready var note_container = $AspectRatioContainer/CenterContainer/NoteContainer
@onready var note_tracks = note_container.get_node('TrackContainer').get_children() as Array[NoteTrack]

func _ready():
	print('Game: Start!')
	load_map(MapContainer.beat_maps[current_map_index]) 
	start()

func _process(delta):
	if(is_game_start):
		time_now = Global.get_current_time()
		time_elapsed = time_now - time_start
		
		for i in range(spawn_notes.size()):
			var track = spawn_notes[i]
			if(!track): continue
			
			#if track[0].stream + time_offset < time_elapsed :
				#note_tracks[i].create_note()
				#spawn_notes[i].pop_front()
				

func start() -> void:
	create_all_notes()
	time_start = Global.get_current_time()
	await get_tree().create_timer(Global.scroll_time + Global.audio_offset).timeout
	print(beat_map.get_max_stream(), ' ', beat_map.repeat_times)
	
	#SoundPlayer.play_sound_by_beats(beat_map.get_max_stream() * beat_map.repeat_times)
	SoundPlayer.play_sound_by_time(beat_map.time + time_offset)

func load_map(p_beat_map: BeatMap) -> void:
	beat_map = p_beat_map
	print('--------')
	SoundPlayer.bpm = beat_map.bpm * bpm_offset
	print('Sound Player BPM: %f' % SoundPlayer.bpm)
	beat_map.notes = beat_map.get_repeat_notes().duplicate(true)
	beat_map.set_beat_map_time()
	beat_map.stream_to_sec()
	
	spawn_notes = beat_map.notes.duplicate(true)
	
	beat_map.print_beat_map_info()
	for i in range(note_tracks.size()):
		if beat_map.notes.size()-1 < i: break
		var note_track : NoteTrack = note_tracks[i]
		#note_track.notes = beat_map.notes[i]
		note_track.set_notes(beat_map.notes[i])


func create_all_notes() -> void:
	for i in range(spawn_notes.size()):
		var track = spawn_notes[i]
		if(!track): continue
		
		while(spawn_notes[i]):
			var time = spawn_notes[i].pop_front().sec_time
			(note_tracks[i] as NoteTrack).create_note_by_sec(time)
			
func restart() -> void:
	print('Game: Restart!')
	get_tree().reload_current_scene()
	spawn_notes = [[]]
	SoundPlayer.stop()
	#start()
	

extends Node2D 

@export var bpm = 0.0

@onready var sound = preload("res://Assets/Sounds/metronome.mp3") 

var isPlaying := false 
var pre_beat_count : int = 0
var beat_count : int = 0

func _ready():
	$BeatSoundPlayer.stream = sound 
	$BeatSoundPlayer.max_polyphony = 1
	
func play_sound_by_beats(beats: int):
	isPlaying = true 
	SoundPlayer.play_sound_bpm(beats) 
	
func play_sound_by_time(time: float):
	isPlaying = true 
	SoundPlayer.play_sound_bpm() 
	await get_tree().create_timer(time).timeout 
	SoundPlayer.stop() 

func play_sound_bpm(beats: int = -1):
	print('Second: %f' % [60 /bpm]) 
		
	while(isPlaying):
		beat_count += 1 
		await get_tree().create_timer(60 / bpm).timeout 
		print(beat_count) if beat_count else print(pre_beat_count)
		if(beats != -1):
			if beat_count >= beats:
				print('over')
				SoundPlayer.stop() 
		
		play_sound() 
	
	print('Total beats: %d' % pre_beat_count)


func play_sound():
#	$BeatSoundPlayer.seek(0.0) 
	$BeatSoundPlayer.play() 

func stop():
	pre_beat_count = beat_count 
	isPlaying = false 
	beat_count = 0 





extends Node2D;

@export var bpm = 120.0;

@onready var sound = preload("res://Assets/Sounds/metronome.mp3");

var isPlaying = false;
var pre_beat_count = 0;
var beat_count = 0;

func play_sound_by_beats(beats: int):
	isPlaying = true;
	SoundPlayer.play_sound_bpm(beats);
	
func play_sound_by_time(time: float):
	isPlaying = true;
	SoundPlayer.play_sound_bpm();
	await get_tree().create_timer(time).timeout;
	SoundPlayer.stop();

func play_sound_bpm(beats: int = -1):
	print('Second: %f' % [60 /bpm]);
		
	while(isPlaying):
		beat_count += 1;
		await get_tree().create_timer(60/ bpm).timeout;
		print(beat_count);
		if(beats != -1):
			if beat_count >= beats:
				print('over')
				SoundPlayer.stop();
		
		play_sound();


func play_sound():
#	$BeatSoundPlayer.seek(0.0);
	$BeatSoundPlayer.play();

func stop():
	pre_beat_count = beat_count;
	beat_count = 0;
	isPlaying = false;


func _ready():
	$BeatSoundPlayer.stream = sound;
	$BeatSoundPlayer.max_polyphony = 10;
	

func _process(delta):
	pass;
	

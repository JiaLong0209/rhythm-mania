extends Node2D;

@onready var sound = preload("res://Sounds/metronome.mp3");

var bpm = 240.0;
var sound_start = false;
var beat_count = 0;

func play_sound_bpm(bpm):
	var s  = 60 / bpm;
	print('Second: %f' % [s]);
	
	while(sound_start):
		beat_count += 1;
		print(beat_count)
		await get_tree().create_timer(s).timeout;
		play_sound();
		

func play_sound():
#	$BeatSoundPlayer.seek(0.0);
	$BeatSoundPlayer.play();


func _ready():
	$BeatSoundPlayer.stream = sound;
	$BeatSoundPlayer.max_polyphony = 10;

	sound_start = true;
	play_sound_bpm(bpm);

func _process(delta):
	pass

extends Control

func _ready():
	pass 

func _process(delta):
	pass


func _on_button_pressed():
#	SoundPlayer.play_sound_by_time(3.0);
	SoundPlayer.play_sound_by_beats(5);

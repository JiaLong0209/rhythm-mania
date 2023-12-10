extends Control

func _ready():
	
	pass 

func _process(delta):
	pass

func _on_button_pressed():
#	SoundPlayer.play_sound_by_time(3.0);
	get_tree().change_scene_to_file('res://Scenes/game.tscn')
	SoundPlayer.play_sound_by_beats(5);

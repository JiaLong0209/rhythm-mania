extends Node

var mode = Global.Mode.Key4
var key_index = range(int(mode)).map(func(x): return x+1)

func _ready():
	pass 

func _input(event):
	if Input.is_action_just_pressed('quit_game'):
		get_tree().quit()
		
	if Global.is_game_start:
		for i in key_index:
			if Input.is_action_just_pressed('game_%s_%d' % [str(mode)+'k', i]):
				press_by_index(i-1)
			if Input.is_action_just_released('game_%s_%d' % [str(mode)+'k', i]):
				release_by_index(i-1)
				
func press_by_index(index: int):
		var note_track = get_tree().get_nodes_in_group('note_track')[index]
		note_track.get_node('IdleNote').press()
	
func release_by_index(index: int):
		var note_track = get_tree().get_nodes_in_group('note_track')[index]
		note_track.get_node('IdleNote').release()
	
	

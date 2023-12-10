extends Node

var mode = '4k'
var key_index = range(int(mode[0])).map(func(x): return x+1)
#var key_index = [1,2,3,4]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Global.is_game_start:
		
		for i in key_index:
			if Input.is_action_just_pressed('game_%s_%d' % [mode, i]):
				press_by_index(i-1)
		
			if Input.is_action_just_released('game_%s_%d' % [mode, i]):
				release_by_index(i-1)
				
func press_by_index(index: int):
		var note_track = get_tree().get_nodes_in_group('note_track')[index]
		note_track.get_node('HitNote').press()
	
func release_by_index(index: int):
		var note_track = get_tree().get_nodes_in_group('note_track')[index]
		note_track.get_node('HitNote').release()
	
	

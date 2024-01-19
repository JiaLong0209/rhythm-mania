extends Node2D

enum Mode { Key0 = 0, Key4 = 4, Key5 = 5, Key6 = 6, Key7 = 7 }

enum NoteType { NOTE = 0, LONG_NOTE = 1 }

enum Judgement { PERFECT = 17, GREAT = 40, GOOD = 80, OK = 110, MEH = 130, MISS = 163 }

enum JudgementType { PERFECT, GREAT, GOOD, OK, MEH, MISS }

@export var user_data : Data = Data.new()

var Colors = {
	'green': Color('55f059'),
	'red': Color(0.9, 0, 0, 1),
	'blue': Color('2551f5'),
	'yellow': Color('fff377'),
	'white': Color('fff'),
}
var hit_result = [ "Perfect", "Great", "Good", "Ok", "Bad", "Miss" ]

# User setting
var scroll_time : float = 0.5
var audio_offset : float = -0.040
var hit_offset : int = 0
var bpm_offset : float = 1.001
var start_time : float = 1.0
var preparation_beat : int = 3

#var dev = true
var dev = false
var is_game_start = true
var judgement_max_error = 200

var transition := 0.4

@onready var screen_size = DisplayServer.screen_get_size()
@onready var window = get_window()

func _ready():
	Engine.max_fps = 120
	print("Global ready")
	user_data.load_default_data()
	if dev:
		test()
		while dev:
			await get_tree().create_timer(1.0).timeout
			#print('FPS: %s' % Engine.get_frames_per_second())
	
func get_bpm_interval(bpm) -> float:
	return 60 / bpm

func get_current_time() -> float:
	return Time.get_unix_time_from_system()

func test():
	user_data.save_game()
	user_data = user_data.load_game()
	user_data.print_beat_maps_info()

extends Node2D
var dev = 1

@export var user_data := Data.new()
@onready var screen_size = DisplayServer.screen_get_size()
@onready var window = get_window()

var is_game_start = true
var scroll_time : float = 2
var judgement : Dictionary = {
	'perfect' : 0.016,
	'great' : 0.050,
	'good' : 0.083,
	'ok' : 0.112,
	'meh': 0.136,
	'miss': 0.173,
}

var green := Color('55f059')
var red := Color(0.9, 0, 0, 1)
var yellow := Color('fff377')
var blue := Color('2551f5')
var white := Color('fff')
var transition := 0.4

func _ready():
	Engine.max_fps = 120
	print("Global ready")
	test()
	while dev:
		await get_tree().create_timer(1.0).timeout
		print(Engine.get_frames_per_second())

func _process(delta):
	return
	
func test() -> void:
	var default_map = BeatMap.new( '4k', 'easy', 60.0, 10.0, 10, [[0.5,0.9]] )
	MapContainer.add_beat_map(default_map)
	user_data.save_game()
	
	var hard_map = BeatMap.new( '4k', 'hard', 180.0, 10.0, 10, [[0.5,0.9], [0.6, 1., 3.]] )
	MapContainer.add_beat_map(hard_map)
	
	print('Global: ', MapContainer.beat_maps)
	user_data.print_beat_maps_info()
	
	user_data = user_data.load_game()
	
	user_data.print_beat_maps_info()

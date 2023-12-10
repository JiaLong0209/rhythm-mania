extends Node2D

@export var data := Data.new()

func _ready():
	print("Global ready")
	test()
	
func test() -> void:
	
	var default_map = BeatMap.new( '4k', 'easy', 60.0, 10.0, 10, [[0.5,0.9]] )
	MapContainer.add_beat_map(default_map)
	data.save_game()
	
	var hard_map = BeatMap.new( '4k', 'hard', 180.0, 10.0, 10, [[0.5,0.9], [0.6, 1., 3.]] )
	MapContainer.add_beat_map(hard_map)
	
	print('Global: ', MapContainer.beat_maps)
	data.print_beat_maps_info()
	
	data = data.load_game()
	
	data.print_beat_maps_info()

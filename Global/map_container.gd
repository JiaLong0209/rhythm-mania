extends Node2D

var beat_maps: Array[BeatMap] = []

func _init():
	pass

func _ready():
	pass

func add_beat_map(beat_map: BeatMap):
	beat_maps.push_back(beat_map)

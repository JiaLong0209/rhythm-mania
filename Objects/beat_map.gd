class_name BeatMap

@export var mode : String = ''
@export var title : String = ''
@export var bpm : float = 0.0
@export var time : float = 0.0
@export var streams : int = 0
@export var notes : Array[Array] = [[]]
@export var play_data : Dictionary = {}

# mode, title, BPM, time, streams, notes
func _init(p_mode: String, p_title: String, p_bpm: float, p_time: float, p_streams: int, p_notes : Array[Array]):
	mode = p_mode
	title = p_title
	bpm = p_bpm
	time = p_time
	streams = p_streams
	notes = p_notes

func _ready():
	pass 



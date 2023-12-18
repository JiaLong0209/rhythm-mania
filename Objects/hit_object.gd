class_name HitObject

var note_stream : float
var sec_time : float
var type : int
var is_random : bool

func _init(p_time: float, p_is_random: bool = false, p_type: int = Global.NoteType.NOTE):
	note_stream = p_time
	type = p_type
	is_random = p_is_random
	
	
func set_sec_time(interval : float):
	sec_time = note_stream * interval

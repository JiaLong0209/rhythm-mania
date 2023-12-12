class_name HitObject

var time : float
var type : int
var is_random : bool

func _init(p_time: float, p_is_random: bool = false, p_type: int = Global.NoteType.NOTE):
	time = p_time
	type = p_type
	is_random = p_is_random
	


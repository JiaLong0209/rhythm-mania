extends Panel

signal pressed

#var original_modulate = Color(0.3, 0.3, 0.3)
var original : Dictionary
var alter : Dictionary
var transition = 0.2

func _ready():
	var alter_size = 1.2
	original = {
		'modulate' : Global.Colors.red,
		'size' : Vector2(1.0, 1.0),
		'position' : -(get_parent() as NoteTrack).track_width_offset / 2,
	}
	alter = {
		'modulate' : Global.Colors.white,
		'size' : Vector2(alter_size, alter_size),
		'position' : -(get_parent() as NoteTrack).track_width_offset / 2 - ($IdleNoteTexture.size.x / 2 * abs(1-alter_size)) ,
	}
	to_original_form(0)

func to_original_form(transition: float = 0.0):
	var tw = create_tween().set_parallel()
	tw.tween_property($IdleNoteTexture, "modulate", original.modulate, transition)
	#tw.tween_property($IdleNoteTexture, "scale", original.size, transition)
	#tw.tween_property($IdleNoteTexture, "position:x", original.position, transition)
	
func to_alter_form(transition: float = 0.0):
	var tw = create_tween().set_parallel()
	tw.tween_property($IdleNoteTexture, "modulate", alter.modulate, transition)
	#tw.tween_property($IdleNoteTexture, "scale", alter.size, transition)
	#tw.tween_property($IdleNoteTexture, "position:x", alter.position, transition)

func press():
	to_alter_form(0.0)
	pressed.emit()

func release():
	to_original_form(transition)

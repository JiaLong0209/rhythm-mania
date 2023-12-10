extends Panel

signal pressed


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func press():
	var tw = create_tween()
	print('press')
	pressed.emit()
	tw.tween_property($HitNoteTexture, "modulate", Global.blue, 0.02)

func release():
	var tw = create_tween()
	print('release')
	tw.tween_property($HitNoteTexture, "modulate", Global.red, 0.02)
	

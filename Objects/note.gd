extends Node2D

var speed : float 
@onready var hit_note = get_parent().get_node('HitNote')


func _ready():
	var distance = abs(position.y - hit_note.position.y)
	speed = distance / Global.scroll_time
	#print('%f %f' % [distance, speed])
	return

func _process(delta):
	position.y += speed * delta
	if(position.y >= Global.window.size.y):
		await get_tree().create_timer(0.2).timeout
		queue_free()

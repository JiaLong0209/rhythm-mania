class_name Note
extends Node2D

@onready var idle_note = get_parent().get_node('IdleNote') 

var speed : float 

func _ready():
	var scroll_time = Global.scroll_time
	var distance = get_distance()
	
	if Global.dev:
		scroll_time = 0.7
	
	speed = distance / scroll_time

func _process(delta):
	position.y += speed * delta
	if(position.y >= Global.window.size.y):
		await get_tree().create_timer(0.2).timeout
		queue_free()

func get_diff() -> float:
	return position.y - (idle_note.position.y + idle_note.size.y / 2)
	
func get_distance() -> float:
	return abs(get_diff())

func get_error_ms_by_dist() -> float:
	var diff = get_diff()
	var error = diff / speed
	
	return error * 1000
	
func get_error_ms_by_time(current: float, target: float) -> float:
	return (current - target) * 1000

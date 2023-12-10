extends Node2D

var speed := 500

func _ready():
	print('Note ready')
	pass 

func _process(delta):
	print(position)
	position.y += speed * delta
	pass

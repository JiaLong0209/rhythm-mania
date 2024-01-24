extends Panel

func _ready():
	get_viewport().connect('size_changed', resize)
	resize()


func resize() -> void:
	custom_minimum_size.y = Global.window.size.y
	print(custom_minimum_size.y)


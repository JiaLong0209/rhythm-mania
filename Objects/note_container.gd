extends Panel

func _ready():
	custom_minimum_size.y = Global.window.size.y
	print(custom_minimum_size.y)
	pass # Replace with function body.


func _process(delta):
	resize()
	pass

func resize() -> void:
	if(custom_minimum_size.y != Global.window.size.y):
		custom_minimum_size.y = Global.window.size.y

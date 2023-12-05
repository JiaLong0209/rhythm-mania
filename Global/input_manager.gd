extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	#print(event))
	if Input.is_action_just_pressed('game_4k_1'):
		#print(event.as_text(), 1)
		print(1);
	if Input.is_action_just_pressed('game_4k_2'):
		print(2);
	if Input.is_action_just_pressed('game_4k_3'):
		print(3);
	if Input.is_action_just_pressed('game_4k_4'):
		print(4);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

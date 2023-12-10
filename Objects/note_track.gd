extends Panel

var dev = 0


@onready var note_scene = preload("res://Objects/note.tscn")
@onready var track = $TrackBG
@onready var spawn_mark = get_node('SpawnMark')
@onready var hit_note = get_node('HitNote')
@onready var hit_note_texture = hit_note.get_node('HitNoteTexture')

var hit_note_offset = -20

func _ready():
	resize()
	test()


func _process(delta):
	resize()
	return

func create_note() -> void:
	var note := note_scene.instantiate()
	note.position = spawn_mark.position
	add_child(note)
	
func resize() -> void:
	track.size.y = Global.window.size.y
	spawn_mark.position.x = track.size.x / 2
	hit_note.size.x = track.size.x
	hit_note.size.y = track.size.x
	hit_note.position.y = Global.window.size.y - hit_note.size.y + hit_note_offset
	

func _on_hit_note_pressed():
	pass


func test():
	while !dev:
		var r = randf_range(0.37, 0.8)
		await get_tree().create_timer(r).timeout
		create_note()	

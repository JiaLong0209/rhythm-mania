class_name  NoteTrack
extends Panel

var idle_note_offset := -40
var track_width_offset := -5
var track_width : float = 0.0
var top_idle_note : bool = false
var notes : Array
var current_note_index : int = 0

@onready var note_scene = preload("res://Objects/note.tscn")
@onready var track = $TrackBG
@onready var spawn_mark = get_node('SpawnMark')
@onready var idle_note = get_node('IdleNote')
@onready var idle_note_texture = idle_note.get_node('IdleNoteTexture')

func _ready():
	get_viewport().connect('size_changed', resize)
	track_width = track.size.x + track_width_offset
	resize()
	
	if Global.dev:
		test()


func _process(delta):
	return

func create_note() -> void:
	var note := note_scene.instantiate()
	note.position = spawn_mark.position
	fit_note_size_to_track(note)
	add_child(note)
	
func create_note_by_sec(time: float) -> void:
	var note := note_scene.instantiate()
	note.position = spawn_mark.position
	fit_note_size_to_track(note)
	await get_tree().create_timer(time).timeout
	#note.set_target_time()
	add_child(note)
	
func set_notes(p_notes: Array) -> void:
	p_notes as Array[HitObject]
	notes = p_notes
			
func fit_note_size_to_track(note: Note) -> void:
	var note_texture = note.get_node('NoteTexture')
	var width = note_texture.texture.get_width()
	var scale = track_width / width 
	note_texture.scale.x = scale
	note_texture.scale.y = scale
	
	
func resize() -> void:
	track.size.y = Global.window.size.y
	spawn_mark.position.x = track.size.x / 2 # original track size 
	idle_note.size.x = track_width
	idle_note.size.y = track_width
	idle_note.position.y = Global.window.size.y - idle_note.size.y + idle_note_offset
	idle_note_texture.position.x = -track_width_offset / 2
	idle_note_texture.size.x = track_width
	
	# if user want to set hit point to the top of hit note
	if top_idle_note: 
		idle_note_texture.position.y = idle_note_texture.size.y / 2
	

func _on_idle_note_pressed() -> void:
	hit()

func hit() -> void:
	var child = get_children()
	for i in child:
		if(i.is_in_group('note')):
			judgement(i)
			break
		
func judgement(note: Note) -> void:
	var error 
	var diff
	match Global.judgement_method:
		Global.JudgementMethod.DISTANCE:
			error = abs(note.get_error_ms_by_dist()) 
		Global.JudgementMethod.TIME:
			if(current_note_index >= notes.size()): return
			print(current_note_index)
			print(notes[current_note_index].sec_time)
			print(Global.current_time)
			diff = (note.get_error_ms_by_time(Global.current_time, notes[current_note_index].sec_time + Global.scroll_time - 0.05))
			error = abs(diff)
	
	
	print('Diff: %f, Error(ms): %f' % [diff, error])
	if error > Global.Judgement.MISS:
		return 
	
	current_note_index += 1
	
	if error < Global.Judgement.PERFECT:
		print(Global.hit_result[Global.JudgementType.PERFECT])
	elif error < Global.Judgement.GREAT:
		print(Global.hit_result[Global.JudgementType.GREAT])
	elif error < Global.Judgement.GOOD:
		print(Global.hit_result[Global.JudgementType.GOOD])
	elif error < Global.Judgement.OK:
		print(Global.hit_result[Global.JudgementType.OK])
	elif error < Global.Judgement.MEH:
		print(Global.hit_result[Global.JudgementType.MEH])
	elif error < Global.Judgement.MISS:
		print(Global.hit_result[Global.JudgementType.MISS])
	
	note.queue_free()
	

# --------Test functions--------

func test() -> void:
	# create note by random time
	while Global.dev:
		var l = 0.6
		var r = 1.4
		var rand = randf_range(l, r)
		await get_tree().create_timer(rand).timeout
		create_note()	

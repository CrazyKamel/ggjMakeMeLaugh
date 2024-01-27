extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	Global.goto_scene("res://src/game.tscn")
	

func _on_quit_button_pressed():
	get_tree().quit()

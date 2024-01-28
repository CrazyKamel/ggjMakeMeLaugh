extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_again_pressed():
	Global.goto_scene("res://src/game.tscn")


func _on_main_menu_pressed():
	Global.goto_scene("res://src/main.tscn")

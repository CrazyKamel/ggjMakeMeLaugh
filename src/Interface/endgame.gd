extends Node

var text_score
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	$Score_end.text = str("Score : ", int(Global.score))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_again_pressed():
	Global.goto_scene("res://src/game.tscn")


func _on_main_menu_pressed():
	Global.goto_scene("res://src/main.tscn")


func _on_play_again_mouse_entered():
	$PlayAgain.set_scale(Vector2(1.1,1.1))


func _on_play_again_mouse_exited():
	$PlayAgain.set_scale(Vector2(1,1))


func _on_main_menu_mouse_entered():
	$MainMenu.set_scale(Vector2(1.1,1.1))


func _on_main_menu_mouse_exited():
	$MainMenu.set_scale(Vector2(1,1))

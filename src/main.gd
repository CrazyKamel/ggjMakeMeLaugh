extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Credits1Ex").hide()
	get_node("Creditsex2").hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	Global.goto_scene("res://src/game.tscn")
	

func _on_quit_button_pressed():
	get_tree().quit()


func _on_menu_button_mouse_entered():
	get_node("Credits1Ex").show()
	get_node("Creditsex2").show()


func _on_menu_button_mouse_exited():
	get_node("Credits1Ex").hide()
	get_node("Creditsex2").hide()


func _on_quit_button_mouse_entered():
	$QuitButton.set_scale(Vector2(1.1,1.1))


func _on_quit_button_mouse_exited():
	$QuitButton.set_scale(Vector2(1,1))


func _on_start_button_mouse_entered():
	$StartButton.set_scale(Vector2(1.1,1.1))


func _on_start_button_mouse_exited():
	$StartButton.set_scale(Vector2(1,1))

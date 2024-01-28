extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yes_pressed():
	Global.goto_scene("res://src/main.tscn")


func _on_no_pressed():
	get_parent().subscribeCancelQuit();
	self.queue_free()


func _on_yes_mouse_entered():
	$Yes.set_scale(Vector2(1.1,1.1))


func _on_yes_mouse_exited():
	$Yes.set_scale(Vector2(1,1))


func _on_no_mouse_entered():
	$No.set_scale(Vector2(1.1,1.1))


func _on_no_mouse_exited():
	$No.set_scale(Vector2(1,1))

extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var confirmQuitInstance = confirmQuit.instantiate()
		add_child(confirmQuitInstance)

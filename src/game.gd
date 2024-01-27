extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit.tscn")
var banane = preload("res://src/banane_stuff.tscn")

var child_count
const bananeNodeName = "Banane"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var confirmQuitInstance = confirmQuit.instantiate()
		print("exit")
		add_child(confirmQuitInstance)

func newBanane(pos = Vector2(200,200)):
	print("Adding banane")
	var banane_instance = banane.instantiate()
	banane_instance.position = pos
	add_child(banane_instance)

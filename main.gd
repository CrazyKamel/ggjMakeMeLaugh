extends Node2D

var messager = preload('res://messager.tscn');
# Called when the node enters the scene tree for the first time.

func inst(pos):
	var instance = messager.instantiate()
	instance.position = pos
	add_child(instance)


func _ready():
	inst(Vector2(0,0))
	inst(Vector2(200,0))
	inst(Vector2(400,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

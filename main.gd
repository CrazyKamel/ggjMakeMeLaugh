extends Node2D

var messager = preload('res://messager.tscn');
var rng = RandomNumberGenerator.new()

const messWidth = 128
const messHeight = 128

#var windowWidth = get_viewport().size.x
#var windowHeight = get_viewport().size.y
# Called when the node enters the scene tree for the first time.

func inst(pos):
	var instance = messager.instantiate()
	instance.position = pos
	add_child(instance)

func _timeout() -> void:
	var x = rng.randi_range(messWidth/2, get_window().size.x - messWidth/2)
	var y = rng.randi_range(messHeight/2, get_window().size.y - messHeight/2)
	
	inst(Vector2(x,y))
	
func _init():
	var timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1
	timer.connect("timeout", self._timeout)

# Fait apparaitre un messager à la pos de la sours lors d'un clic
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		inst(get_global_mouse_position())


func _ready():
	inst(Vector2(0,0))
	inst(Vector2(200,0))
	inst(Vector2(400,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

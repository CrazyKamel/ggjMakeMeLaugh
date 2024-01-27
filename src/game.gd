extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit.tscn")
var banane = preload("res://src/banane_stuff.tscn")
var messager = preload('res://src//Messager/messager.tscn')

var rng = RandomNumberGenerator.new()

var child_count
const bananeNodeName = "Banane"
const messWidth = 128
const messHeight = 128
var confirmQuitCheck = true

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
	timer.autostart = false
	timer.one_shot = false
	timer.wait_time = 1
	timer.connect("timeout", self._timeout)

# Called when the node enters the scene tree for the first time.
func _ready(): 	
	inst(Vector2(600,400))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func subscribeCancelQuit():
	confirmQuitCheck = true

func _input(event):
	if event.is_action_pressed("ui_cancel") && confirmQuitCheck:
		var confirmQuitInstance = confirmQuit.instantiate()
		add_child(confirmQuitInstance)
		confirmQuitCheck = false

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		inst(get_global_mouse_position())

func newBanane(pos = Vector2(200,200)):
	var banane_instance = banane.instantiate()
	banane_instance.position = pos
	add_child(banane_instance)

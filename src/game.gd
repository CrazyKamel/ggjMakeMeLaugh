extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit.tscn")
var banane = preload("res://src/banane_stuff.tscn")
var messager = preload('res://src//Messager/messager.tscn')
var hud_preload = preload("res://src/hud.tscn")

var rng = RandomNumberGenerator.new()
var hud

var child_count
const bananeNodeName = "Banane"
const messWidth = 128
const messHeight = 128
var confirmQuitCheck = true

var probaSpawn = 0.1
var nbSpawned = 0

func addLaugh(toAdd):
	hud.addLaugh(toAdd)

func subLaugh(toSub):
	hud.subLaugh(toSub)
	
func inst(pos):
	var instance = messager.instantiate()
	instance.position = pos
	add_child(instance)

func _timeout() -> void:
	if Global.rng.randf() < probaSpawn:
		var border = Global.rng.randi_range(0,1)
		var y = Global.rng.randi_range(get_window().size.y*0.26 + messHeight/2, get_window().size.y)
		var x = -messWidth/2 if border == 0 else get_window().size.x + messWidth/2
		
		inst(Vector2(x,y))
		nbSpawned+=1
		if nbSpawned%20==0:
			probaSpawn+=0.01
			print(probaSpawn," ", nbSpawned)

func _init():
	var timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 0.1
	timer.connect("timeout", self._timeout)

# Called when the node enters the scene tree for the first time.
func _ready():
	hud = hud_preload.instantiate()
	add_child(hud)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hud.subLaugh(probaSpawn/10)
	pass

func subscribeCancelQuit():
	confirmQuitCheck = true

func _input(event):
	if event.is_action_pressed("ui_cancel") && confirmQuitCheck:
		var confirmQuitInstance = confirmQuit.instantiate()
		add_child(confirmQuitInstance)
		confirmQuitCheck = false


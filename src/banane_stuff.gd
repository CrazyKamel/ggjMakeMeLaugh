extends Node2D

var inBody = false
var follow = false
var available = true
var onTable = true

func newBanane():
	print("Banane cd fini")
	available = true
	self.show()

func dropBanane():
	print("Dropped")
	available = false
	self.hide()
	var timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.one_shot = true
	timer.wait_time = 5
	timer.connect("timeout", self.newBanane)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow:
		self.position = get_global_mouse_position()
	pass

func _input(event):
	if available and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and inBody:
			print("Onit pressed")
			follow = true
			pass
		elif follow and not event.pressed:
			print("Onit released")
			follow = false
			if not onTable:
				dropBanane()
				
			pass


func _on_area_2d_mouse_shape_entered(shape_idx):
	inBody = true
	pass # Replace with function body.


func _on_area_2d_mouse_shape_exited(shape_idx):
	inBody = false
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	print("Entered")
	onTable = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	print("Left")
	onTable = false
	pass # Replace with function body.

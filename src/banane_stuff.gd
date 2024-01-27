extends Node2D

var inBody = false
var follow = false
var available = true
var onTable = true

const cooldownBanane = 5

var banane_ingame = preload("res://src/banane_ingame.tscn")

func _timeout():
	available = true
	self.position = Vector2(950,850)
	self.show()

func dropBanane():
	
	available = false
	self.hide()
	
	var timer = Timer.new()
	get_parent().add_child(timer)
	timer.one_shot = true
	timer.wait_time = cooldownBanane
	timer.connect("timeout", self._timeout)
	timer.start()
	
	var added_banane = banane_ingame.instantiate()
	added_banane.position = self.position
	get_parent().add_child(added_banane)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if follow:
		$Sprite2D.modulate = Color(1,1,1,0.4)
		self.position = get_global_mouse_position()
	pass

func _input(event):
	if available and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and inBody:
			follow = true
			pass
		elif follow and not event.pressed:
			$Sprite2D.modulate = Color(1,1,1,1)
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
	onTable = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	onTable = false
	pass # Replace with function body.

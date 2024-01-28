extends Node2D

var startBar
var endBar
var currentLaugh = 50.0

func updateCurseur():
	if currentLaugh > 100: currentLaugh = 100
	if currentLaugh <= 0: currentLaugh = 0
	$Curseur.position.x = ((endBar-startBar)/100)*currentLaugh + startBar
	pass

func setCurseur(percent):
	currentLaugh = percent
	updateCurseur()
	pass

func addLaugh(toAdd):
	currentLaugh+=toAdd
	updateCurseur()

func subLaugh(toSub):
	currentLaugh-=toSub
	updateCurseur()


# Called when the node enters the scene tree for the first time.
func _ready():
	startBar = int($LaughBar.position.x - ($LaughBar.texture.get_width() * $LaughBar.get_scale().x)/2)
	endBar = int($LaughBar.position.x + ($LaughBar.texture.get_width() * $LaughBar.get_scale().x)/2)
	
	print(startBar)
	print(endBar)
	
	setCurseur(50)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

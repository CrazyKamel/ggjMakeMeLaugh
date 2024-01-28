extends Node2D

var startBar
var endBar
var currentLaugh = 50.0

var score = 0
var combo = 0
var text_score
var text_combo
var sizeCombo = 40
var ft = 40
var buffer = 0


func updateScore(laughPoints):
	if laughPoints > 1:
		combo += 1
		score += int(laughPoints*(117*combo))
		text_score.text = str(int(score))
		updateCombo()
		
	elif laughPoints < -1:
		combo = 0
		updateCombo()
			

func updateCombo():
	if combo > 0:
		text_combo.text = str("x", combo)
		ft = sizeCombo + -0.7*combo+30
		#text_combo.theme.font_size = sizeCombo + combo*3
	else:
		text_combo.text = ""


func updateCurseur():
	if currentLaugh < 0:
		#Animation du roi qui est en colère
		Global.score = score
		Global.goto_scene("res://src/Interface/endgame.tscn")
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
	updateScore(toAdd)
	updateCurseur()

func subLaugh(toSub):
	currentLaugh-=toSub
	updateScore(-toSub)
	updateCurseur()


# Called when the node enters the scene tree for the first time.
func _ready():
	startBar = int($LaughBar.position.x - ($LaughBar.texture.get_width() * $LaughBar.get_scale().x)/2)
	endBar = int($LaughBar.position.x + ($LaughBar.texture.get_width() * $LaughBar.get_scale().x)/2)
	
	text_score = $Score
	text_combo = $Score/Combo
	
	print(startBar)
	print(endBar)
	
	setCurseur(50)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if combo > 0:
		if ft > sizeCombo:
			buffer = (buffer+1)%3
			if buffer == 0:
				ft -= 1
		else:
			combo -= 1
			updateCombo()
	pass

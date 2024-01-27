extends CharacterBody2D

var speed = 50
var norme
var vecteur_direction
var vecteur_vitesse

func _ready():
	norme = (Vector2(960, 540) - self.position).length()
	vecteur_direction = (Vector2(960, 540) - position)/norme
	vecteur_vitesse = vecteur_direction * speed
	
func _physics_process(delta): 
	self.position = self.position + vecteur_vitesse*delta
	
func _process(delta):
	if abs((Vector2(960, 540) - self.position).x) < 100 and abs((Vector2(960, 540) - self.position).y) < 100 :
		self.queue_free()

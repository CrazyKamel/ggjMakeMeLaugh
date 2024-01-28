class_name Roi extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	king_anim_default()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func king_anim_laugh():
	$AnimatedSprite2D.play("laugh")

func king_anim_mad():
	$AnimatedSprite2D.play("mad")

func king_anim_default():
	$AnimatedSprite2D.play("default")

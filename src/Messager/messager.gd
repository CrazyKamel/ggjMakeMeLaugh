class_name Messager extends Area2D

enum State {GOOD, BAD, KNIGHT}

@export var start_speed = 100 #Vitesse du messager à l'origine
var start_velocity # Vecteur vitesse du messager à l'origine
var velocity # Vecteur vitesse du messager à la frame présente
var norme
var vecteur_direction

var position_visee = Vector2(960, 540)

var sens # 0 = gauche ; 1 = droite

var selected = false #Variable indiquant si le messager est sélectionné
var last_velocity = Vector2(0,0) #Dernière velocité avant qu'on lâche le click
var pos_1 : Vector2 #buffer position à t-1
var pos_2 : Vector2 #buffer position à t
var screen_size

var state

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Récupère la taille de la fenêtre
	
	$AnimatedSprite2D.play() # lance l'animation
	
	vecteur_direction = calc_direction()
	start_velocity = vecteur_direction * start_speed # set la vitesse à l'origine
	velocity = start_velocity # set la vitesse à la vitesse d'origine
	state = Global.rng.randi_range(0,2)
	set_animation(state, "grabbed")

func _physics_process(delta):
	if selected:
		set_animation(state, "grabbed")
		pos_1 = pos_2
		pos_2 = position
		last_velocity = get_speed(pos_1, pos_2, delta)
		
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		
		#last_velocity = Vector2.ZERO
	elif abs(last_velocity.length()) > start_speed*1.05:
		set_animation(state, "grabbed")
		position += last_velocity*delta
		last_velocity = last_velocity-((last_velocity+start_velocity)/15)
	else:
		set_animation(state, "walk")
		vecteur_direction = calc_direction()
		velocity = vecteur_direction * start_speed
		self.position = self.position + velocity*delta

func _process(delta):
	if abs((position_visee - self.position).x) < 100 and abs((position_visee - self.position).y) < 100 :
		self.queue_free()

### Tools
func get_speed(pos_1:Vector2, pos_2:Vector2, delta):
	return (pos_2-pos_1)/delta 
	
func set_animation(state, animationstyle):
	if (animationstyle == "grabbed"):
		match state:
			0:
				$AnimatedSprite2D.play("bn_grabbed") #change to GOOD messager animation
			1:
				$AnimatedSprite2D.play("mn_grabbed") #change to BAD messager animation
			2:
				$AnimatedSprite2D.play("armor_grabbed") #change to KNIGHT messager animation
	elif (animationstyle == "walk" ):
		match state:
			0:
				$AnimatedSprite2D.play("bn_walk") #change to GOOD messager animation
			1:
				$AnimatedSprite2D.play("mn_walk") #change to BAD messager animation
			2:
				$AnimatedSprite2D.play("armor_walk") #change to KNIGHT messager animation
	$AnimatedSprite2D.flip_h = sens

func calc_direction():
	norme = (position_visee - self.position).length()
	vecteur_direction = (position_visee - position)/norme
	if vecteur_direction.x>0:
		sens=1
	else:
		sens=0
	return vecteur_direction


### Function Input
func _on_input_event(viewport, event, shape_idx): # Quand on fait un input sur le messager
	if Input.is_action_just_pressed("Click"): # Quand on fait un clic gauche
		selected = true
		
func _input(event): # Quand on relache le clique gauche
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

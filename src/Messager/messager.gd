class_name Messager extends Area2D

enum State {GOOD, BAD, KNIGHT}

var probaSpawnTypes = {"good":0.35,"bad": 0.9} # GOOD, BAD, KNIGHT
var damage = {"good":2,"bad": 4,"knight": 6} # GOOD, BAD, KNIGHT

@export var start_speed_messager = 100 #Vitesse du messager à l'origine du messager
@export var start_speed_armor = 50 #Vitesse du messager à l'origine du knight
var start_speed #Vitesse du messager à l'origine
var start_velocity # Vecteur vitesse du messager à l'origine
var velocity # Vecteur vitesse du messager à la frame présente
var norme
var vecteur_direction

var happyBubbleSprite
var angryBubbleSprite

var glideForceNormal = 20
var glideForceArmor = 0.1

var glideForce

var position_visee = Vector2(960, 440)
var starting_pos
var aller = true
var tempo = 100
var frozen = false

var sens # 0 = gauche ; 1 = droite

var selected = false #Variable indiquant si le messager est sélectionné
var last_velocity = Vector2(0,0) #Dernière velocité avant qu'on lâche le click
var pos_1 : Vector2 #buffer position à t-1
var pos_2 : Vector2 #buffer position à t
var screen_size

var state

# Called when the node enters the scene tree for the first time.
func _ready():
	happyBubbleSprite = $bubble_happy
	angryBubbleSprite = $bubble_angry
	
	starting_pos = Vector2(self.position.x * 1.3, self.position.y)
	
	screen_size = get_viewport_rect().size # Récupère la taille de la fenêtre
	
	$AnimatedSprite2D.play() # lance l'animation
	
	
	var r = Global.rng.randf()
	if r >= probaSpawnTypes["bad"]: #0.9 - 1
		state = 2 #knight
		happyBubbleSprite.hide()
		glideForce = glideForceArmor
		start_speed = start_speed_armor
		$AudioStreamPlayer2D.play() #plays metal sound for ~3secs (can be changed)
	elif r < probaSpawnTypes["bad"] and r > probaSpawnTypes["good"]: #0.35 - 0.9
		state = 1 #bad
		happyBubbleSprite.hide()
		glideForce = glideForceNormal
		start_speed = start_speed_messager
	else: #0 - 0.35
		state = 0 #good
		angryBubbleSprite.hide()
		start_speed = start_speed_messager
		glideForce = glideForceNormal
	
	vecteur_direction = calc_direction()
	start_velocity = vecteur_direction * start_speed # set la vitesse à l'origine
	velocity = start_velocity # set la vitesse à la vitesse d'origine
	
	set_animation(state, "walk")

func _physics_process(delta):
	if selected:
		set_animation(state, "grabbed")
		pos_1 = pos_2
		pos_2 = position
		last_velocity = get_speed(pos_1, pos_2, delta)
		
		global_position = lerp(global_position, get_global_mouse_position(), glideForce * delta)
		
		#last_velocity = Vector2.ZERO
	elif abs(last_velocity.length()) > start_speed*1.05:
		
		if not frozen:
			set_animation(state, "grabbed")
			self.position += last_velocity*delta
		last_velocity = last_velocity-((last_velocity+start_velocity)/15)
	else:
		
		vecteur_direction = calc_direction()
		velocity = vecteur_direction * start_speed
		if not frozen:
			set_animation(state, "walk")
			self.position += velocity*delta

func _process(delta):
	if abs((position_visee - self.position).x) < 100 and abs((position_visee - self.position).y) < 100 and aller:
		match state:
			0:
				get_parent().addLaugh(damage["good"])
				happyBubbleSprite.hide()
				
				$AudioStreamPlayer2D5.play()
			1:
				get_parent().subLaugh(damage["bad"])
				angryBubbleSprite.hide()
				$AudioStreamPlayer2D3.play()
			2:
				get_parent().subLaugh(damage["knight"])
				angryBubbleSprite.hide()
				$AudioStreamPlayer2D2.play()
		
		aller = false
		set_animation(state, "stopped")
		frozen = true
	elif not aller:
		tempo -= 1
		if tempo <= 0:
			position_visee = starting_pos
			frozen = false
			
		#self.queue_free()
		

### Tools
func get_speed(pos_1:Vector2, pos_2:Vector2, delta):
	return (pos_2-pos_1)/delta 
	
func set_animation(state, animationstyle):
	if (animationstyle == "grabbed"):
		match state:
			0:
				$AnimatedSprite2D.play("messager_grabbed") #change to GOOD messager animation
			1:
				$AnimatedSprite2D.play("messager_grabbed") #change to BAD messager animation
			2:
				$AnimatedSprite2D.play("armor_grabbed") #change to KNIGHT messager animation
	elif (animationstyle == "walk" ):
		match state:
			0:
				$AnimatedSprite2D.play("messager_walk") #change to GOOD messager animation
			1:
				$AnimatedSprite2D.play("messager_walk") #change to BAD messager animation
			2:
				$AnimatedSprite2D.play("armor_walk") #change to KNIGHT messager animation
	elif (animationstyle == "stopped" ):
		match state:
			0:
				$AnimatedSprite2D.play("messager_stopped") #change to GOOD messager animation
			1:
				$AnimatedSprite2D.play("messager_stopped") #change to BAD messager animation
			2:
				$AnimatedSprite2D.play("armor_stopped") #change to KNIGHT messager animation
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
			if abs(last_velocity.length()) >= start_speed*1.1:
				$AudioStreamPlayer2D4.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

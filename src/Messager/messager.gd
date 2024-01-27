extends Area2D

@export var start_velocity = Vector2(400,0) #Vitesse du messager à l'origine
var velocity # Vitesse du messager à la frame présente
var selected = false #Variable indiquant si le messager est sélectionné
var last_velocity = Vector2(0,0) #Dernière velocité avant qu'on lâche le click
var pos_1 : Vector2 #buffer position à t-1
var pos_2 : Vector2 #buffer position à t
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Récupère la taille de la fenêtre
	$AnimatedSprite2D.play() # lance l'animation
	velocity = start_velocity # set la vitesse à l'origine


func _physics_process(delta):
	if selected:
		$AnimatedSprite2D.animation = "grabbed"
		pos_1 = pos_2
		pos_2 = position
		last_velocity = get_speed(pos_1, pos_2, delta)
		
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		print(last_velocity, last_velocity.length())
		
		#last_velocity = Vector2.ZERO
	elif abs(last_velocity.length()) > abs(start_velocity.length())*1.05:
		$AnimatedSprite2D.animation = "grabbed"
		#global_position = lerp(global_position, get_global_mouse_position(), 1 * delta)
		position += last_velocity*delta
		last_velocity = last_velocity-((last_velocity+start_velocity)/15)
	else:
		$AnimatedSprite2D.animation = "walk"
		position += velocity*delta


### Tools
func get_speed(pos_1:Vector2, pos_2:Vector2, delta):
	return (pos_2-pos_1)/delta 


### Function Input
func _on_input_event(viewport, event, shape_idx): # Quand on fait un input sur le messager
	if Input.is_action_just_pressed("Click"): # Quand on fait un clic gauche
		selected = true
		
func _input(event): # Quand on relache le clique gauche
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false

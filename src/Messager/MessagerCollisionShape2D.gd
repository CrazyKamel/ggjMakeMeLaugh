
extends CollisionShape2D


@onready var character_body_2d: CharacterBody2D = $CharacterBody2D


func _ready() -> void:
	character_body_2d.input_pickable = true
	character_body_2d.input_event.connect(_on_character_input_event)


func _on_character_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event)
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_area_entered(area):
	if area is Messager:
		$AudioStreamPlayer.play()
		hide()
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
		get_parent().addLaugh(0.4)
		area.queue_free()


func _on_audio_stream_player_finished():
	queue_free()
	pass # Replace with function body.

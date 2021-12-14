extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BotaoIniciar_pressed():
	get_tree().change_scene("res://Scenes/Fases.tscn")


func _on_BotaoSair_pressed():
	get_tree().quit()



func _on_BotaoControles_pressed():
	get_tree().change_scene("res://Scenes/Controle.tscn")
